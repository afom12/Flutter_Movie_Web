import 'package:flutter/material.dart';
import '../data/mock_data.dart';
import '../models/movie.dart';
import 'detail_screen.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _controller = TextEditingController();
  List<Movie> _results = [];

  void _searchMovies(String query) {
    final lowerQuery = query.toLowerCase();
    setState(() {
      _results = mockMovies
          .where((movie) => movie.title.toLowerCase().contains(lowerQuery))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('🔍 Search'),
        backgroundColor: Colors.deepPurple,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              onChanged: _searchMovies,
              decoration: InputDecoration(
                hintText: 'Search movies or series...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: _results.isEmpty
                  ? const Center(child: Text('No results yet'))
                  : ListView.builder(
                      itemCount: _results.length,
                      itemBuilder: (context, index) {
                        final movie = _results[index];
                        return ListTile(
                          leading: ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.asset(movie.imageUrl, width: 60, fit: BoxFit.cover),
                          ),
                          title: Text(movie.title),
                          subtitle: Text("${movie.language} • ⭐ ${movie.rating}"),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => DetailScreen(movie: movie),
                              ),
                            );
                          },
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
