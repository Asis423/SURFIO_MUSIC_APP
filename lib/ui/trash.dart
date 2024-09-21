import 'package:flutter/material.dart';
import 'home_screen.dart'; // For navigation back to HomeScreen

class RecommendScreen extends StatefulWidget {
  @override
  _RecommendScreenState createState() => _RecommendScreenState();
}

class _RecommendScreenState extends State<RecommendScreen> {
  List<String> selectedGenres = [];
  List<String> selectedArtists = [];
  double danceability = 0.5;
  double energy = 0.5;
  double valence = 0.5;

  // Sample genres and artists (replace with your actual data)
  final List<String> genres = ['Pop', 'Rock', 'Jazz', 'Hip Hop'];
  final List<String> artists = ['Artist A', 'Artist B', 'Artist C'];

  int _selectedIndex = 1; // The Recommend tab is selected

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF252525),
        elevation: 0,
        automaticallyImplyLeading: false,
        title: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    // Implement search functionality here, similar to SearchScreen
                  },
                  child: Container(
                    height: 35,
                    decoration: BoxDecoration(
                      color: Color(0xFF3F3F3F),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 12),
                    child: Row(
                      children: [
                        Icon(Icons.search, color: Colors.grey),
                        SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            'Search songs, albums and artists',
                            style: TextStyle(color: Colors.grey, fontSize: 14),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Icon(Icons.tune, color: Colors.grey),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      body: Container(
        color: Color(0xFF232323), // Same background color as HomeScreen
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Mood, Genre, Artist selection, and Sliders similar to your previous code
            Text('Select Genres:', style: TextStyle(fontSize: 18, color: Colors.white)),
            Wrap(
              children: genres.map((genre) {
                return ChoiceChip(
                  label: Text(genre),
                  selected: selectedGenres.contains(genre),
                  onSelected: (selected) {
                    setState(() {
                      selected ? selectedGenres.add(genre) : selectedGenres.remove(genre);
                    });
                  },
                );
              }).toList(),
            ),
            SizedBox(height: 20),
            Text('Select Artists:', style: TextStyle(fontSize: 18, color: Colors.white)),
            Wrap(
              children: artists.map((artist) {
                return ChoiceChip(
                  label: Text(artist),
                  selected: selectedArtists.contains(artist),
                  onSelected: (selected) {
                    setState(() {
                      selected ? selectedArtists.add(artist) : selectedArtists.remove(artist);
                    });
                  },
                );
              }).toList(),
            ),
            SizedBox(height: 20),
            // Sliders for Danceability, Energy, Valence
            Text('Danceability: ${danceability.toStringAsFixed(2)}', style: TextStyle(color: Colors.white)),
            Slider(
              value: danceability,
              min: 0,
              max: 1,
              onChanged: (value) {
                setState(() {
                  danceability = value;
                });
              },
            ),
            Text('Energy: ${energy.toStringAsFixed(2)}', style: TextStyle(color: Colors.white)),
            Slider(
              value: energy,
              min: 0,
              max: 1,
              onChanged: (value) {
                setState(() {
                  energy = value;
                });
              },
            ),
            Text('Valence: ${valence.toStringAsFixed(2)}', style: TextStyle(color: Colors.white)),
            Slider(
              value: valence,
              min: 0,
              max: 1,
              onChanged: (value) {
                setState(() {
                  valence = value;
                });
              },
            ),
            ElevatedButton(
              onPressed: () {
                // Call the function to recommend songs based on selected criteria
                recommendSongs();
              },
              child: Text('Get Recommendations'),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Color(0xFF171717),
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home, color: _selectedIndex == 0 ? Colors.purple : Colors.white),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.recommend, color: _selectedIndex == 1 ? Colors.purple : Colors.white),
            label: 'Recommend',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.purple,
        unselectedItemColor: Colors.white,
        onTap: (index) {
          if (index == 0) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => HomeScreen()), // Redirect to HomeScreen
            );
          }
        },
      ),
    );
  }

  void recommendSongs() {
    // Implement your recommendation logic here using the selected attributes
  }
}

