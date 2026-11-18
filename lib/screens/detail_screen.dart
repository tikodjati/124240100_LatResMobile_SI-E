import 'package:material_ui/material_ui.dart';
import 'package:url_launcher/url_launcher.dart';
import '../services/favorite_service.dart';

class DetailScreen extends StatefulWidget {
  // Menerima map data artikel dari list_screen (Modul 4 - Passing Data)
  final Map<String, dynamic> item;

  const DetailScreen({super.key, required this.item});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  bool isFavorite = false; // Status apakah sedang difavoritkan

  @override
  void initState() {
    super.initState();
    _checkFavoriteStatus();
  }

  void _checkFavoriteStatus() async {
    final fav = await FavoriteService.isFavorite(widget.item['id']);
    if (mounted) {
      setState(() {
        isFavorite = fav;
      });
    }
  }

  // Fungsi untuk membuka link web luar (url_launcher)
  Future<void> _launchURL(String urlString) async {
    final Uri uri = Uri.parse(urlString);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Tidak dapat membuka tautan berita')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final item = widget.item;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail'),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
        actions: [
          // Tombol Favorite di pojok kanan atas AppBar
          IconButton(
            icon: Icon(
              isFavorite ? Icons.favorite : Icons.favorite_border,
              color: isFavorite ? Colors.red : Colors.white,
            ),
            onPressed: () async {
              // Simpan / hapus dari storage lokal
              final bool nowFav =
                  await FavoriteService.toggleFavorite(widget.item);

              if (!mounted) return;
              setState(() {
                isFavorite = nowFav;
              });

              // Munculkan snackbar sesuai gambar di soal
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    nowFav
                        ? 'Ditambahkan ke favorite'
                        : 'Dihapus dari favorite',
                  ),
                  duration: const Duration(seconds: 1),
                ),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 1. Gambar Besar di Bagian Atas
            Image.network(
              item['image_url'] ?? '',
              width: double.infinity,
              height: 220,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  height: 220,
                  color: Colors.grey[300],
                  child: const Center(
                    child: Icon(
                      Icons.broken_image,
                      size: 60,
                      color: Colors.grey,
                    ),
                  ),
                );
              },
            ),

            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 2. Judul Berita
                  Text(
                    item['title'] ?? 'Tanpa Judul',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),

                  // 3. Author Data
                  Text(
                    item['news_site'] ?? 'Unknown Author',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[700],
                      fontWeight: FontWeight.w500,
                    ),
                  ),

                  // 4. Tanggal Publish
                  Text(
                    item['published_at'] ?? '',
                    style: TextStyle(fontSize: 12, color: Colors.grey[500]),
                  ),
                  const Divider(height: 24),

                  // 5. Summary Berita
                  Text(
                    item['summary'] ?? 'Tidak ada ringkasan.',
                    style: const TextStyle(fontSize: 15, height: 1.5),
                  ),
                  const SizedBox(height: 24),

                  // 6. Tombol Buka Web (Launch URL)
                  Align(
                    alignment: Alignment.centerRight,
                    child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.deepPurple,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 12,
                        ),
                      ),
                      onPressed: () {
                        final String url = item['url'] ?? '';
                        if (url.isNotEmpty) {
                          _launchURL(url);
                        }
                      },
                      icon: const Icon(Icons.open_in_new, size: 18),
                      label: const Text('Buka Web'),
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
}
