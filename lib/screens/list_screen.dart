import 'package:material_ui/material_ui.dart';

class ListScreen extends StatefulWidget {
  final String title;
  final String endpoint;

  const ListScreen({super.key, required this.title, required this.endpoint});

  @override
  State<ListScreen> createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Judul AppBar otomatis sesuai dengan card yang diklik
        title: Text(widget.title),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: Text(
          'Halaman untuk: ${widget.title}\nEndpoint:${widget.endpoint}',
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
