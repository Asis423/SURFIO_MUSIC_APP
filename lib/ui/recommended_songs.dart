import 'package:flutter/material.dart';
import 'package:surfio_music_app/ui/player/music_player.dart';

class RecommendedSongsScreen extends StatelessWidget {
  final List<dynamic> recommendations;
  final String typedText;

  RecommendedSongsScreen({required this.recommendations, required this.typedText});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Recommended Songs', style: TextStyle(color: Colors.white, fontSize: 20)),
        backgroundColor: Color(0xFF171717),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              "Results for '$typedText'",
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
                  onTap: () => _navigateToMusicPlayer(context, song),
                );
              },
            ),
          ),
        ],
      ),
      backgroundColor: Color(0xFF232323),
    );
  }

  // Function to navigate to the custom music player
  void _navigateToMusicPlayer(BuildContext context, dynamic song) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CustomMusicPlayer(
          trackName: song['Track Name'],
          artistName: song['Artist Name(s)'],
          albumArtUrl: song['Album Image URL'],
          trackUrl: song['Track URL'], // Pass the Track URL for playback
          trackDuration: song['Track Duration (ms)'],
        ),
      ),
    );
  }
}
