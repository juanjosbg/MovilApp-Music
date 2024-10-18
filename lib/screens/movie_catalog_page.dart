import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'Movie/movie_details_screen.dart';
import '../utils/avorite_manager.dart';

class MovieCatalogPage extends StatefulWidget {
  @override
  _MovieCatalogPageState createState() => _MovieCatalogPageState();
}

class _MovieCatalogPageState extends State<MovieCatalogPage> {
  List movies = [];
  String query = '';

  @override
  void initState() {
    super.initState();
    fetchMovies();
  }

  Future<void> fetchMovies() async {
    try {
      final response = await http.get(Uri.parse(
          'https://api.themoviedb.org/3/movie/popular?api_key=112301cf1d0ae64c6cf7cba24deef8b0'));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          movies = data['results'];
        });
      } else {
        throw Exception('Failed to load movies: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching movies: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error fetching movies: $e'),
        ),
      );
    }
  }

  void searchMovies(String query) {
    setState(() {
      this.query = query.toLowerCase();
    });
  }

  // Función para alternar el estado de favorito
  Future<void> toggleFavorite(String movieId) async {
    bool isFavorite = await FavoriteManager.isFavorite(movieId);
    if (isFavorite) {
      await FavoriteManager.removeFavorite(movieId);
    } else {
      await FavoriteManager.addFavorite(movieId);
    }
    setState(() {}); // Actualizar el estado para reflejar los cambios en la UI
  }

  @override
  Widget build(BuildContext context) {
    // Filtramos las películas en base al query
    List filteredMovies = movies.where((movie) {
      final titleLower = movie['title'].toLowerCase();
      return titleLower.contains(query);
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text('Movie Catalog'),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(50),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search Movies',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
              onChanged: searchMovies,
            ),
          ),
        ),
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(16.0),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: MediaQuery.of(context).size.width > 600 ? 3 : 1,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          childAspectRatio: 2 / 3,
        ),
        itemCount: filteredMovies.length,
        itemBuilder: (context, index) {
          final movie = filteredMovies[index];
          final movieId = movie['id'].toString(); // ID de la película

          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MovieDetailsScreen(
                      movie: movie, query: query), // Pasamos la query actual
                ),
              ).then((_) {
                // Al regresar a la página de catálogo, volver a buscar la película
                searchMovies(query);
              });
            },
            child: Card(
              elevation: 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Image.network(
                      'https://image.tmdb.org/t/p/w500${movie['poster_path']}',
                      fit: BoxFit.cover,
                      width: double.infinity,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Mostrar el título de la película
                        Expanded(
                          child: Text(
                            movie['title'],
                            style: TextStyle(fontWeight: FontWeight.bold),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        // Icono de estrella para favoritos
                        FutureBuilder(
                          future: FavoriteManager.isFavorite(movieId),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return CircularProgressIndicator();
                            }
                            bool isFavorite = snapshot.data ?? false;
                            return IconButton(
                              icon: Icon(
                                isFavorite ? Icons.star : Icons.star_border,
                                color: isFavorite ? Colors.yellow : Colors.grey,
                              ),
                              onPressed: () {
                                toggleFavorite(movieId); // Alternar favoritos
                              },
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
