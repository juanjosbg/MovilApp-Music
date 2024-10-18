// anime_details_screen.dart
import 'package:flutter/material.dart';

class AnimeDetailsScreen extends StatelessWidget {
  final dynamic anime;

  AnimeDetailsScreen({required this.anime});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(anime['title']),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Imagen del anime
            Center(
              child: Image.network(
                anime['images']['jpg']['image_url'],
                width: 200,
                height: 300,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: 16),

            // Título del anime
            Text(
              anime['title'],
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),

            // Géneros
            Text(
              'Genres: ' +
                  (anime['genres'] as List)
                      .map((genre) => genre['name'])
                      .join(', '),
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
            SizedBox(height: 8),

            // Calificación
            Text(
              'Rating: ${anime['score'] ?? 'N/A'}',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
            SizedBox(height: 8),

            // Sinopsis
            Text(
              'Synopsis',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              anime['synopsis'] ?? 'No synopsis available',
              style: TextStyle(fontSize: 14),
            ),
            SizedBox(height: 16),

            // Más detalles si los tienes (como elenco, episodios, etc.)
            Text(
              'Episodes: ${anime['episodes'] ?? 'N/A'}',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 8),
            Text(
              'Status: ${anime['status'] ?? 'N/A'}',
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
