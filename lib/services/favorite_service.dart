import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class FavoriteService {
  static const String _key = 'favorite_items';

  // Mengambil semua data favorit yang tersimpan
  static Future<List<Map<String, dynamic>>> getFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    final String? dataString = prefs.getString(_key);
    if (dataString == null || dataString.isEmpty) {
      return [];
    }
    try {
      final List<dynamic> decoded = jsonDecode(dataString);
      return decoded.map((e) => Map<String, dynamic>.from(e as Map)).toList();
    } catch (e) {
      return [];
    }
  }

  // Mengecek apakah suatu berita sudah difavoritkan
  static Future<bool> isFavorite(dynamic id) async {
    final favorites = await getFavorites();
    return favorites.any((item) => item['id'] == id);
  }

  // Menambah atau menghapus favorit (Toggle)
  static Future<bool> toggleFavorite(Map<String, dynamic> item) async {
    final prefs = await SharedPreferences.getInstance();
    final favorites = await getFavorites();
    final int index = favorites.indexWhere((fav) => fav['id'] == item['id']);

    bool isNowFav = false;
    if (index >= 0) {
      // Jika sudah ada, hapus dari favorit
      favorites.removeAt(index);
      isNowFav = false;
    } else {
      // Jika belum ada, tambahkan ke favorit
      favorites.add({
        'id': item['id'],
        'title': item['title'] ?? 'Tanpa Judul',
        'image_url': item['image_url'] ?? '',
        'news_site': item['news_site'] ?? 'Unknown Author',
        'summary': item['summary'] ?? '',
        'published_at': item['published_at'] ?? '',
        'url': item['url'] ?? '',
      });
      isNowFav = true;
    }

    await prefs.setString(_key, jsonEncode(favorites));
    return isNowFav;
  }
}
