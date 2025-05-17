





import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/watchlist_provider.dart';
import 'detail_screen.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final watchlist = context.watch<WatchlistProvider>().watchlist;

    return Scaffold(
      appBar: AppBar(
        title: const Text('⭐ Favorites'),
        backgroundColor: Colors.deepPurple,
      ),
      body: watchlist.isEmpty
          ? const Center(child: Text('No favorites yet 💔'))
          : ListView.builder(
              itemCount: watchlist.length,
              itemBuilder: (context, index) {
                final movie = watchlist[index];
                return ListTile(
                  leading: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.asset(movie.imageUrl, width: 60, fit: BoxFit.cover),
                  ),
                  title: Text(movie.title),
                  subtitle: Text('${movie.language} • ${movie.genre}'),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () {
                      context.read<WatchlistProvider>().toggleWatchlist(movie);
                    },
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => DetailScreen(movie: movie)),
                    );
                  },
                );
              },
            ),
    );
  }
}
