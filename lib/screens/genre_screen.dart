import 'package:flutter/material.dart';
import '../models/movie.dart';
import '../screens/detail_screen.dart';
import '../widgets/movie_card.dart';

class GenreScreen extends StatefulWidget {
  final String genre;
  final List<Movie> movies;

  const GenreScreen({super.key, required this.genre, required this.movies});

  @override
  State<GenreScreen> createState() => _GenreScreenState();
}

class _GenreScreenState extends State<GenreScreen> {
  String sortBy = 'Rating';

  List<Movie> get sortedMovies {
    final filtered = widget.movies.where((m) => m.genre == widget.genre).toList();
    if (sortBy == 'Rating') {
      filtered.sort((a, b) => b.rating.compareTo(a.rating));
    } else {
      filtered.sort((a, b) => DateTime.parse(b.releaseDate).compareTo(DateTime.parse(a.releaseDate)));
    }
    return filtered;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.genre} Movies'),
        backgroundColor: Colors.deepPurple,
        actions: [
          PopupMenuButton<String>(
            onSelected: (value) => setState(() => sortBy = value),
            itemBuilder: (context) => [
              const PopupMenuItem(value: 'Rating', child: Text('Sort by Rating')),
              const PopupMenuItem(value: 'Year', child: Text('Sort by Year')),
            ],
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: sortedMovies.isEmpty
            ? const Center(child: Text('No movies in this genre.'))
            : GridView.builder(
                itemCount: sortedMovies.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 16,
                  crossAxisSpacing: 16,
                  childAspectRatio: 0.65,
                ),
                itemBuilder: (context, index) {
                  final movie = sortedMovies[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => DetailScreen(movie: movie)),
                      );
                    },
                    child: MovieCard(movie: movie),
                  );
                },
              ),
      ),
    );
  }
}
