import 'package:flutter/material.dart';
import '../data/mock_data.dart';
import '../widgets/category_slider.dart';
import '../models/movie.dart';
import 'genre_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String selectedLanguage = 'All';
  String sortBy = 'Rating';
  final List<String> languages = ['All', 'Amharic', 'English', 'Korean'];
  final List<String> genres = ['Action', 'Romance', 'Crime', 'Comedy', 'Horror', 'Sci-Fi', 'Drama'];

  List<Movie> get filteredMovies {
    List<Movie> results = mockMovies.where((movie) {
      final matchLang = selectedLanguage == 'All' || movie.language == selectedLanguage;
      return matchLang;
    }).toList();

    if (sortBy == 'Rating') {
      results.sort((a, b) => b.rating.compareTo(a.rating));
    } else {
      results.sort((a, b) => DateTime.parse(b.releaseDate).compareTo(DateTime.parse(a.releaseDate)));
    }

    return results;
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: Colors.black,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text('MOVIEVERSE', style: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          letterSpacing: 1.5,
        )),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.search, size: 28),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.person_outline, size: 28),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            // Hero Banner
            SizedBox(
              height: size.height * 0.6,
              child: Stack(
                children: [
                  // Background Image
                  Positioned.fill(
                    child: Image.network(
                      'https://image.tmdb.org/t/p/original/9yBVqNruk6Ykrwc32qrK2TIE5xw.jpg',
                      fit: BoxFit.cover,
                      color: Colors.black.withOpacity(0.4),
                      colorBlendMode: BlendMode.darken,
                    ),
                  ),
                  
                  // Movie Info
                  Positioned(
                    bottom: 40,
                    left: 20,
                    right: 20,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'NOW STREAMING',
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: Colors.white.withOpacity(0.8),
                            letterSpacing: 2,
                          ),
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          'Dune: Part Two',
                          style: TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            shadows: [
                              Shadow(
                                blurRadius: 10,
                                color: Colors.black,
                                offset: Offset(2, 2),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 12),
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                              decoration: BoxDecoration(
                                color: Colors.amber,
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: const Row(
                                children: [
                                  Icon(Icons.star, size: 16, color: Colors.black),
                                  SizedBox(width: 4),
                                  Text(
                                    '9.2',
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 12),
                            const Text(
                              '2024 • 2h 46m • Sci-Fi',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.white70,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red,
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            onPressed: () {},
                            child: const Text(
                              'WATCH NOW',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Filters Section
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.grey.shade900,
                    Colors.black,
                  ],
                ),
              ),
              child: Column(
                children: [
                  // Sort Row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'SORT BY',
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: Colors.white54,
                          letterSpacing: 1,
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade800,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            value: sortBy,
                            dropdownColor: Colors.grey.shade900,
                            icon: const Icon(Icons.keyboard_arrow_down, color: Colors.white),
                            items: ['Rating', 'Year']
                                .map((option) => DropdownMenuItem(
                                      value: option,
                                      child: Text(
                                        option,
                                        style: const TextStyle(color: Colors.white),
                                      ),
                                    ))
                                .toList(),
                            onChanged: (value) {
                              setState(() {
                                sortBy = value!;
                              });
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // Language Chips
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'LANGUAGES',
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: Colors.white54,
                          letterSpacing: 1,
                        ),
                      ),
                      const SizedBox(height: 8),
                      SizedBox(
                        height: 40,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: languages.length,
                          itemBuilder: (context, index) {
                            final value = languages[index];
                            final isSelected = value == selectedLanguage;
                            return Padding(
                              padding: const EdgeInsets.only(right: 8),
                              child: FilterChip(
                                label: Text(value),
                                selected: isSelected,
                                onSelected: (_) => setState(() => selectedLanguage = value),
                                selectedColor: Colors.red,
                                backgroundColor: Colors.grey.shade800,
                                labelStyle: TextStyle(
                                  color: isSelected ? Colors.white : Colors.white70,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // Genre Chips
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'BROWSE BY GENRE',
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: Colors.white54,
                          letterSpacing: 1,
                        ),
                      ),
                      const SizedBox(height: 8),
                      SizedBox(
                        height: 40,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: genres.length,
                          itemBuilder: (context, index) {
                            final genre = genres[index];
                            return Padding(
                              padding: const EdgeInsets.only(right: 8),
                              child: ActionChip(
                                label: Text(genre),
                                backgroundColor: Colors.grey.shade800,
                                labelStyle: const TextStyle(color: Colors.white),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) => GenreScreen(
                                        genre: genre,
                                        movies: filteredMovies,
                                      ),
                                    ),
                                  );
                                },
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Content Sections
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
              child: Column(
                children: [
                  // Trending Section
                  _buildSectionHeader('Trending Now', () {}),
                  const SizedBox(height: 12),
                  CategorySlider(
                    category: 'Trending',
                    movies: filteredMovies,
                    cardHeight: 180,
                  ),
                  const SizedBox(height: 24),

                  // Top Rated Section
                  _buildSectionHeader('Top Rated', () {}),
                  const SizedBox(height: 12),
                  CategorySlider(
                    category: 'Top Rated',
                    movies: filteredMovies,
                    cardHeight: 180,
                  ),
                  const SizedBox(height: 24),

                  // New Releases Section
                  _buildSectionHeader('New Releases', () {}),
                  const SizedBox(height: 12),
                  CategorySlider(
                    category: 'New Releases',
                    movies: filteredMovies,
                    cardHeight: 180,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomNavBar(),
    );
  }

  Widget _buildSectionHeader(String title, VoidCallback onSeeAll) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        TextButton(
          onPressed: onSeeAll,
          child: const Text(
            'See All',
            style: TextStyle(
              color: Colors.red,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildBottomNavBar() {
    return Container(
      height: 70,
      decoration: BoxDecoration(
        color: Colors.black,
        border: Border(top: BorderSide(color: Colors.grey.shade800, width: 0.5)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildNavItem(Icons.home_filled, 'Home', true),
          _buildNavItem(Icons.explore_outlined, 'Discover', false),
          _buildNavItem(Icons.bookmark_border, 'Watchlist', false),
          _buildNavItem(Icons.download_outlined, 'Downloads', false),
        ],
      ),
    );
  }

  Widget _buildNavItem(IconData icon, String label, bool isActive) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          icon,
          color: isActive ? Colors.red : Colors.white54,
          size: 26,
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            color: isActive ? Colors.red : Colors.white54,
            fontSize: 10,
          ),
        ),
      ],
    );
  }
}