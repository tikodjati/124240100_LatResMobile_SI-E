import 'package:material_ui/material_ui.dart';
import '../services/favorite_service.dart';
import 'detail_screen.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({super.key});

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  List<Map<String, dynamic>> _favorites = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadFavorites();
  }

  Future<void> _loadFavorites() async {
    final data = await FavoriteService.getFavorites();
    if (mounted) {
      setState(() {
        _favorites = data;
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorite'),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _favorites.isEmpty
              ? const Center(
                  child: Text(
                    'Belum ada berita favorit.',
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                )
              : ListView.builder(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  itemCount: _favorites.length,
                  itemBuilder: (context, index) {
                    final item = _favorites[index];
                    return Card(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 6),
                      child: ListTile(
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
                        title: Text(
                          item['title'] ?? 'Tanpa Judul',
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        subtitle: Text(item['news_site'] ?? 'Unknown Author'),
                        trailing: IconButton(
                          icon: const Icon(Icons.favorite, color: Colors.red),
                          onPressed: () async {
                            // Hapus langsung dari halaman favorit
                            await FavoriteService.toggleFavorite(item);
                            _loadFavorites(); // Refresh list otomatis
                            if (!mounted) return;
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Dihapus dari favorite'),
                                duration: Duration(seconds: 1),
                              ),
                            );
                          },
                        ),
                        onTap: () async {
                          // Buka detail screen, dan saat kembali refresh list otomatis
                          await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DetailScreen(item: item),
                            ),
                          );
                          _loadFavorites(); // Refresh saat kembali dari DetailScreen
                        },
                      ),
                    );
                  },
                ),
    );
  }
}
