import 'dart:convert';

import 'package:http/http.dart' as http;

String articleApiUrl = "https://api.spaceflightnewsapi.net/v4/articles/";
String blogApiUrl = "https://api.spaceflightnewsapi.net/v4/blogs/";
String reportApiUrl = "https://api.spaceflightnewsapi.net/v4/reports/";

// News : https://api.spaceflightnewsapi.net/v4/articles/
// Blogs : https://api.spaceflightnewsapi.net/v4/blogs/
// Report : https://api.spaceflightnewsapi.net/v4/reports/

Future<List<dynamic>> getArticles() async {
  final response = await http.get(Uri.parse(articleApiUrl));
  if (response.statusCode == 200) {
    final data = jsonDecode(response.body);
    return data['articles'];
  } else {
    throw Exception('Failed to load products');
  }
}

Future<List<dynamic>> getBlogs() async {
  final response = await http.get(Uri.parse(blogApiUrl));
  if (response.statusCode == 200) {
    final data = jsonDecode(response.body);
    return data['blogs'];
  } else {
    throw Exception('Failed to load products');
  }
}

Future<List<dynamic>> getProducts() async {
  final response = await http.get(Uri.parse(apiUrl));
  if (response.statusCode == 200) {
    final data = jsonDecode(response.body);
    return data['products'];
  } else {
    throw Exception('Failed to load products');
  }
}
