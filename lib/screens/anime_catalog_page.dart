import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../screens/Anime/anime_details_screen.dart'; // Importa la pantalla de detalles

class AnimeCatalogPage extends StatefulWidget {
  @override
  _AnimeCatalogPageState createState() => _AnimeCatalogPageState();
}

class _AnimeCatalogPageState extends State<AnimeCatalogPage> {
  List<dynamic> animeList = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchAnimeData();
  }

  Future<void> fetchAnimeData() async {
    try {
      final response =
          await http.get(Uri.parse('https://api.jikan.moe/v4/anime'));

      if (response.statusCode == 200) {
        setState(() {
          animeList = json.decode(response.body)['data'];
          isLoading = false;
        });
      } else {
        throw Exception('Failed to load anime data');
      }
    } catch (e) {
      setState(() {
        isLoading = false; // Detener el loading en caso de error
      });
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final crossAxisCount = screenWidth > 600
        ? 3
        : 2; // 3 columnas en pantallas grandes (>600) y 2 en móviles

    return Scaffold(
      appBar: AppBar(
        title: Text('Anime Catalog'),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : GridView.builder(
              padding: const EdgeInsets.all(15.0),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: crossAxisCount,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                childAspectRatio: 1,
              ),
              itemCount: animeList.length,
              itemBuilder: (context, index) {
                final anime = animeList[index];

                return GestureDetector(
                  onTap: () {
                    // Navegar a la pantalla de detalles
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AnimeDetailsScreen(
                            anime: anime), // Pasar el anime completo
                      ),
                    );
                  },
                  child: Card(
                    elevation: 2,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: ClipRRect(
                            borderRadius:
                                BorderRadius.vertical(top: Radius.circular(4)),
                            child: Image.network(
                              anime['images']['jpg']['image_url'],
                              fit: BoxFit.cover,
                              width: double.infinity,
                              height: double.infinity,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            anime['title'],
                            style: TextStyle(fontWeight: FontWeight.bold),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
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
