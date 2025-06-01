



import 'package:flutter/material.dart';
import '../models/movie.dart';

class WatchlistProvider with ChangeNotifier {
  final List<Movie> _watchlist = [];

  List<Movie> get watchlist => _watchlist;

  void toggleWatchlist(Movie movie) {
    if (_watchlist.contains(movie)) {
      _watchlist.remove(movie);
    } else {
      _watchlist.add(movie);
    }
    notifyListeners();
  }

  // Add to your WatchlistProvider
void sortByRating() {
  _watchlist.sort((a, b) => b.rating.compareTo(a.rating));
  notifyListeners();
}

void sortByDateAdded() {
  // Assuming you add a 'dateAdded' property to Movie
  _watchlist.sort((a, b) => b.dateAdded.compareTo(a.dateAdded));
  notifyListeners();
}

  bool isInWatchlist(Movie movie) {
    return _watchlist.contains(movie);
  }
}
