import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:latihan_responsi/screens/detail_screen.dart';
import 'package:material_ui/material_ui.dart';

class ListScreen extends StatefulWidget {
  final String title;
  final String endpoint;

  const ListScreen({super.key, required this.title, required this.endpoint});

  @override
  State<ListScreen> createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> {
  List<dynamic> listData = [];
  bool isLoading = true;
  String _username = '';

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    final String url =
        'https://api.spaceflightnewsapi.net/v4/${widget.endpoint}/';

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        setState(() {
          listData = data['results'];
          isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      print('Error: $e');
    }
  }

  void _loadUsername() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      // Mengambil string dengan key 'username'
      _username = prefs.getString('username') ?? 'User';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : ScrollConfiguration(
              behavior: ScrollConfiguration.of(context)
                  .copyWith(overscroll: false),
              child: ListView.builder(
                physics: const BouncingScrollPhysics(),
                itemCount: listData.length,
                itemBuilder: (context, index) {
                  final item = listData[index];
                  return ListTile(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DetailScreen(item: item),
                        ),
                      );
                    },
                    title: Text(
                      item['title'] ?? 'Tanpa Judul',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    subtitle: Text(
                      item['authors'][0]['name'] ?? 'Unknown Author',
                    ),
                    leading: Image.network(
                      item['image_url'],
                      width: 50,
                      height: 50,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return const Icon(
                          Icons.broken_image,
                          size: 50,
                        ); // ✅ Exception handling gambar rusak
                      },
                    ),
                  );
                },
              ),
            ),
    );
  }
}
