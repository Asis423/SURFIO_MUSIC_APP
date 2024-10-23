import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'player/music_player.dart'; // Import the CustomMusicPlayer

class GenreRecommendedSongsScreen extends StatelessWidget {
  final List<dynamic> recommendations;
  final String selectedGenres;

  GenreRecommendedSongsScreen({required this.recommendations, required this.selectedGenres});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Recommended Songs by Genre', style: TextStyle(color: Colors.white, fontSize: 20)),
        backgroundColor: Color(0xFF171717),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: recommendations.isEmpty
          ? Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            "No songs found for the selected genre(s). Please try another genre.",
            style: TextStyle(color: Colors.white, fontSize: 16),
            textAlign: TextAlign.center,
          ),
        ),
      )
          : Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              "Results for genres: $selectedGenres",
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: recommendations.length,
              itemBuilder: (context, index) {
                final song = recommendations[index];
                return ListTile(
                  leading: song['Album Image URL'] != null
                      ? Image.network(
                    song['Album Image URL'],
                    width: 50,
                    height: 50,
                    fit: BoxFit.cover,
                  )
                      : SizedBox(width: 50, height: 50), // Placeholder if no image
                  title: Text(
                    song['Track Name'],
                    style: TextStyle(color: Colors.white),
                  ),
                  subtitle: Text(
                    song['Artist Name(s)'],
                    style: TextStyle(color: Colors.grey),
                  ),
                  trailing: Icon(Icons.play_arrow, color: Colors.purple),
                  onTap: () {
                    // Navigate to CustomMusicPlayer
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CustomMusicPlayer(
                          trackName: song['Track Name'],
                          artistName: song['Artist Name(s)'],
                          albumArtUrl: song['Album Image URL'] ?? '', // Handle null
                          trackUrl: song['Track URL'],
                          trackDuration: 0, // Update with actual duration if available
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
      backgroundColor: Color(0xFF232323),
    );
  }
}
