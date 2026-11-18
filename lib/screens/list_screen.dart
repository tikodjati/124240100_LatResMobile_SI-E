import 'dart:convert';
import 'package:material_ui/material_ui.dart';
import 'package:http/http.dart' as http;
import 'detail_screen.dart';
import 'favorite_screen.dart';

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
  String? selectedAuthor;

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
          listData = data['results'] ?? [];
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

  @override
  Widget build(BuildContext context) {
    // 1. Ambil daftar author unik dari data API
    final List<String> authors = listData
        .map((item) => item['news_site']?.toString() ?? '')
        .where((site) => site.isNotEmpty)
        .toSet()
        .toList();

    // 2. Filter data sesuai author yang dipilih
    final List<dynamic> displayedList = selectedAuthor == null
        ? listData
        : listData
            .where((item) => item['news_site'] == selectedAuthor)
            .toList();

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.favorite, color: Colors.white),
            tooltip: 'Halaman Favorite',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const FavoriteScreen(),
                ),
              );
            },
          ),
        ],
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                // Deretan Chip Filter Horizontal (Bisa digeser ke samping)
                if (authors.isNotEmpty)
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    child: Row(
                      children: authors.map((author) {
                        final bool isSelected = selectedAuthor == author;
                        return Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: FilterChip(
                            label: Text(author),
                            selected: isSelected,
                            onSelected: (bool selected) {
                              setState(() {
                                // Jika di-klik lagi saat aktif, batalkan pilihan (tampilkan semua)
                                selectedAuthor = selected ? author : null;
                              });
                            },
                          ),
                        );
                      }).toList(),
                    ),
                  ),

                // List Data yang Sudah Terfilter
                Expanded(
                  child: ScrollConfiguration(
                    behavior: ScrollConfiguration.of(context)
                        .copyWith(overscroll: false),
                    child: ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      itemCount: displayedList.length,
                      itemBuilder: (context, index) {
                        final item = displayedList[index];
                        return Card(
                          margin: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 6),
                          child: ListTile(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      DetailScreen(item: item),
                                ),
                              );
                            },
                            title: Text(
                              item['title'] ?? 'Tanpa Judul',
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            subtitle:
                                Text(item['news_site'] ?? 'Unknown Author'),
                            leading: ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Image.network(
                                item['image_url'] ?? '',
                                width: 50,
                                height: 50,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) {
                                  return const Icon(
                                    Icons.broken_image,
                                    size: 50,
                                  );
                                },
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}
