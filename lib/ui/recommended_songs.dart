import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

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
                  onTap: () => launchSpotifyUri(context, song['Track Web URL']),
                );
              },
            ),
          ),
        ],
      ),
      backgroundColor: Color(0xFF232323),
    );
  }

  void launchSpotifyUri(BuildContext context, String url) async {
    final Uri uri = Uri.parse(url); // Parse the URL
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri); // Use launchUrl for the new API
    } else {
      _showErrorDialog(context, 'Could not launch Spotify app or web.');
    }
  }

  void _showErrorDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Error'),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
