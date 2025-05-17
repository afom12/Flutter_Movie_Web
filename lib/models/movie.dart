


class Movie {
  final String id;
  final String title;
  final String language;
  final String category;
  final String genre;
  final String imageUrl;
  final String description;
  final double rating;
  final String releaseDate;
  final DateTime dateAdded;

  Movie({
    required this.id,
    required this.title,
    required this.language,
    required this.category,
    required this.genre,
    required this.imageUrl,
    required this.description,
    required this.rating,
    required this.releaseDate,
    DateTime? dateAdded, // Make this optional
  }) : dateAdded = dateAdded ?? DateTime.now();

  // Get the year from releaseDate (assuming format is "YYYY-MM-DD")
  String get year => releaseDate.split('-').first;

  // Optionally add a duration property if needed for your app
  // String get duration => '2h 30m'; // Example format

  // Optionally add toJson/fromJson methods if you need serialization
  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'language': language,
        'category': category,
        'genre': genre,
        'imageUrl': imageUrl,
        'description': description,
        'rating': rating,
        'releaseDate': releaseDate,
        
      };

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      id: json['id'],
      title: json['title'],
      language: json['language'],
      category: json['category'],
      genre: json['genre'],
      imageUrl: json['imageUrl'],
      description: json['description'],
      rating: json['rating'].toDouble(),
      releaseDate: json['releaseDate'],
    );
  }
}
