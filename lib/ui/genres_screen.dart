import 'package:flutter/material.dart';
import 'package:http/http.dart' as http; // For HTTP requests
import 'dart:convert'; // For JSON encoding/decoding
import 'genre_recommend.dart'; // Import the screen for genre recommendations

class GenresScreen extends StatefulWidget {
  @override
  _GenresScreenState createState() => _GenresScreenState();
}

class _GenresScreenState extends State<GenresScreen> {
  final List<String> genres = [
    'Rock', 'Pop', 'Hip-Hop', 'Jazz', 'Classical', 'Indie',
    'Electronic', 'Blues', 'Metal', 'Country',
    'Acoustic', 'Folk', 'R&B', 'Soul', 'Punk',
    // Adding most used genres from your dataset
    'Dance Pop', 'K-Pop', 'Glam Rock', 'Big Room',
    'Afrobeats', 'Latin',
  ];

  final List<String> selectedGenres = [];

  Future<List<dynamic>> fetchRecommendations() async {
    // Build the URL with selected genres
    String url = 'http://192.168.2.7:8000/music/genre?selected_genres=${selectedGenres.join(",")}';

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      // Parse the JSON response
      final data = json.decode(response.body);
      return data['recommendations'];
    } else {
      throw Exception('Failed to load recommendations');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF232323),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 20.0),
              child: Text(
                'Songs by Genre',
                style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
            Expanded(
              child: Wrap(
                spacing: 12.0,
                runSpacing: 20.0,
                children: genres.map((genre) => _buildGenreButton(genre)).toList(),
              ),
            ),
            SizedBox(height: 20),
            _buildRecommendButton(context),
          ],
        ),
      ),
    );
  }

  Widget _buildGenreButton(String genre) {
    final bool isSelected = selectedGenres.contains(genre);

    return GestureDetector(
      onTap: () {
        setState(() {
          if (isSelected) {
            selectedGenres.remove(genre);
          } else {
            selectedGenres.add(genre);
          }
        });
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 6.0, horizontal: 16.0),
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(20.0),
          border: Border.all(
            color: isSelected ? Colors.purple : Colors.white,
            width: 2.0,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (isSelected)
              Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: Icon(
                  Icons.check,
                  color: Colors.purple,
                  size: 18.0,
                ),
              ),
            Text(
              genre,
              style: TextStyle(
                color: isSelected ? Colors.purple : Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRecommendButton(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.purple,
          padding: EdgeInsets.symmetric(vertical: 16.0),
        ),
        onPressed: () async {
          try {
            // Fetch recommendations from the backend
            List<dynamic> recommendations = await fetchRecommendations();

            // Navigate to the GenreRecommendedSongsScreen with the fetched recommendations
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => GenreRecommendedSongsScreen(
                  recommendations: recommendations,
                  selectedGenres: selectedGenres.join(', '),
                ),
              ),
            );
          } catch (e) {
            _showErrorDialog(context, 'Error fetching recommendations: $e');
          }
        },
        child: Text(
          'Recommend',
          style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ),
    );
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
