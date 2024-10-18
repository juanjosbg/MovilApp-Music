import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class FavoriteManager {
  static const String favoriteKey = 'favorite_movies';

  // Obtener la lista de favoritos desde SharedPreferences
  static Future<List<String>> getFavorites() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? favoritesJson = prefs.getString(favoriteKey);
    if (favoritesJson != null) {
      return List<String>.from(jsonDecode(favoritesJson));
    }
    return [];
  }

  // Agregar una película a los favoritos
  static Future<void> addFavorite(String movieId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> favorites = await getFavorites();
    favorites.add(movieId);
    prefs.setString(favoriteKey, jsonEncode(favorites));
  }

  // Eliminar una película de los favoritos
  static Future<void> removeFavorite(String movieId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> favorites = await getFavorites();
    favorites.remove(movieId);
    prefs.setString(favoriteKey, jsonEncode(favorites));
  }

  // Verificar si una película está en los favoritos
  static Future<bool> isFavorite(String movieId) async {
    List<String> favorites = await getFavorites();
    return favorites.contains(movieId);
  }
}
