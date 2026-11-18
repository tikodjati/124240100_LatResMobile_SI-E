import 'package:latihan_responsi/screens/list_screen.dart';
import 'package:latihan_responsi/screens/login_screen.dart';
import 'package:material_ui/material_ui.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // ini ga kepake jirrr
  // List<dynamic> articles = [];
  // List<dynamic> blogs = [];
  // List<dynamic> reports = [];

  // bool isLoadingArticles = true;
  // bool isLoadingBlogs = true;
  // bool isLoadingReports = true;

  // Future<void> fetchArticles() async {
  //   try {
  //     final articleData = await getArticles();
  //     setState(() {
  //       articles = articleData;
  //       isLoadingArticles = false;
  //     });
  //   } catch (e) {
  //     setState(() {
  //       isLoadingArticles = false;
  //     });
  //     print('Error: $e');
  //   }
  // }

  // Future<void> fetchBlogs() async {
  //   try {
  //     final blogData = await getArticles();
  //     setState(() {
  //       blogs = blogData;
  //       isLoadingBlogs = false;
  //     });
  //   } catch (e) {
  //     setState(() {
  //       isLoadingBlogs = false;
  //     });
  //     print('Error: $e');
  //   }
  // }

  // Future<void> fetchReports() async {
  //   try {
  //     final reportData = await getArticles();
  //     setState(() {
  //       articles = reportData;
  //       isLoadingReports = false;
  //     });
  //   } catch (e) {
  //     setState(() {
  //       isLoadingReports = false;
  //     });
  //     print('Error: $e');
  //   }
  // }

  // @override
  // void initState() {
  //   super.initState();
  //   getArticles();
  //   getBlogs();
  //   getReports();
  // }

  void _logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('loginData', false);
    if (mounted) {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const LoginScreen()),
        (route) => false,
      );
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hai, Tiko!'),
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // 1. Card News
            Card(
              child: ListTile(
                leading: const Icon(Icons.newspaper, color: Colors.deepPurple),
                title: const Text(
                  'News',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: const Text(
                  'Get an overview of the latest SpaceFlight news, from various sources! Easily link your users to the right websites.',
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          const ListScreen(title: 'News', endpoint: 'articles'),
                    ),
                  );
                  // nanti navigasi ke list news
                },
              ),
            ),
            const SizedBox(height: 12),

            // 2. Card Blog
            Card(
              child: ListTile(
                leading: const Icon(Icons.article, color: Colors.deepPurple),
                title: const Text(
                  'Blog',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: const Text(
                  'Blogs often provide a more detailed overview of launches and missions. A must-have for the serious spaceflight enthusiast.',
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          const ListScreen(title: 'Blogs', endpoint: 'blogs'),
                    ),
                  );
                  // nanti navigasi ke list blog
                },
              ),
            ),
            const SizedBox(height: 12),

            // 3. Card Reports
            Card(
              child: ListTile(
                leading: const Icon(Icons.analytics, color: Colors.deepPurple),
                title: const Text(
                  'Reports',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: const Text(
                  'Space stations and other missions often publish their data. With SNAPI, you can include it in your app.',
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ListScreen(
                        title: 'Reports',
                        endpoint: 'reports',
                      ),
                    ),
                  );
                  // nanti navigasi ke list report
                },
              ),
            ),

            // Spacer() ini otomatis mendorong tombol logout ke bagian paling bawah layar!
            const Spacer(),

            // 4. Tombol Logout merah yang sudah kamu buat
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onPressed: _logout,
                child: const Text('Logout', style: TextStyle(fontSize: 16)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AddTodoScreen {}
