import 'package:flutter/material.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Recommend Songs')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Mood Selection
            Text('Select Mood:', style: TextStyle(fontSize: 18)),
            // Add Mood Options (Radio buttons, etc.)

            // Genre Selection
            Text('Select Genres:', style: TextStyle(fontSize: 18)),
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

            // Artist Selection
            Text('Select Artists:', style: TextStyle(fontSize: 18)),
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

            // Sliders for Danceability, Energy, Valence
            Text('Danceability: ${danceability.toStringAsFixed(2)}'),
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
            Text('Energy: ${energy.toStringAsFixed(2)}'),
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
            Text('Valence: ${valence.toStringAsFixed(2)}'),
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

            // Submit Button
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
            icon: Icon(Icons.home, color: Colors.white),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.recommend, color: Colors.purple),
            label: 'Recommend',
          ),
        ],
        currentIndex: 1,
        onTap: (index) {
          // Handle bottom navigation tap
        },
      ),
    );
  }

  void recommendSongs() {
    // Implement your recommendation logic here using the selected attributes
    // Filter your dataset based on the selected genres, artists, and slider values
  }
}
