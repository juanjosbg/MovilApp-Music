import 'package:flutter/material.dart';

class MovieDetailsScreen extends StatelessWidget {
  final Map movie;
  final String query;

  const MovieDetailsScreen({Key? key, required this.movie, required this.query})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final posterUrl = 'https://image.tmdb.org/t/p/w500${movie['poster_path']}';

    return Scaffold(
      appBar: AppBar(
        title: Text(movie['title']),
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
              onChanged: (value) {
                // Aquí puedes implementar la lógica de búsqueda, si lo deseas.
                print('Searching: $value');
              },
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Imagen de la película
            Container(
              width: 350,
              child: Image.network(
                posterUrl,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(width: 20),
            // Espacio entre la imagen y la información
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    movie['title'],
                    style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),
                  Text(
                    movie['original_title'], // Título original como subtítulo
                    style: TextStyle(fontSize: 18, color: Colors.grey),
                  ),
                  SizedBox(height: 8),
                  // Meta información
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 16.0),
                        child: Text(
                          movie['release_date']
                              .substring(0, 4), // Año de lanzamiento
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 16.0),
                        child: Text(
                          "HD",
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16),
                  // Descripción de la película
                  Text(
                    movie['overview'], // Sinopsis
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: 16),
                  // Información adicional
                  Container(
                    margin: EdgeInsets.only(top: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Additional Information',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 8),
                        // Lista de información
                        _buildInfoList(movie),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoList(Map movie) {
    // Reflejar la información
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildInfoItem('Director:', 'Shane Rasco'),
        _buildInfoItem('Genres:', 'Music, TV Movie, Documentary'),
        _buildInfoItem('Actors:',
            'Aaron Carter, AJ McLean, Melanie Martin, Taylor Helgeson, Dr. Travis Stork'),
      ],
    );
  }

  Widget _buildInfoItem(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$title ',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Expanded(
              child: Text(value, style: TextStyle(color: Colors.grey[700]))),
        ],
      ),
    );
  }
}
