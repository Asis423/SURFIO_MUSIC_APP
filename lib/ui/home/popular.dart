import 'package:flutter/material.dart';
import 'package:http/http.dart' as http; // For making HTTP requests
import 'dart:convert'; // For JSON decoding
import '../player/music_player.dart'; // Import your music player

class PopularSection extends StatefulWidget {
  final VoidCallback onSeeAll; // Callback for the "See All" button

  PopularSection({required this.onSeeAll});

  @override
  _PopularSectionState createState() => _PopularSectionState();
}

class _PopularSectionState extends State<PopularSection> {
  List<dynamic> popularSongs = []; // List to hold the popular songs
  bool isLoading = true; // Loading state

  @override
  void initState() {
    super.initState();
    _fetchPopularSongs(); // Fetch the songs when the widget initializes
  }

  Future<void> _fetchPopularSongs() async {
    final url = 'http://172.16.2.100:8000/music/popular'; // Replace with your backend URL
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          popularSongs = data['popular_music']; // Adjust according to your response structure
          isLoading = false; // Stop loading
        });
      } else {
        setState(() {
          isLoading = false; // Stop loading on error
        });
      }
    } catch (e) {
      setState(() {
        isLoading = false; // Stop loading on error
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 13.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Popular Songs',
                style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
              ),
              GestureDetector(
                onTap: widget.onSeeAll, // Call the passed callback when "See All" is clicked
                child: Row(
                  children: [
                    Text('See All', style: TextStyle(color: Color(0xFFE0E0E0))),
                    Icon(Icons.arrow_forward_ios_outlined, color: Color(0xFFE0E0E0), size: 16),
                  ],
                ),
              ),
            ],
          ),
        ),
        Container(
          height: 200, // Height of the horizontal list
          child: isLoading
              ? Center(child: CircularProgressIndicator()) // Show loading spinner while fetching
              : ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: popularSongs.length, // Use the dynamic length
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: _buildMusicCard(popularSongs[index]), // Pass the song data to the card
              );
            },
          ),
        ),
      ],
    );
  }

  // Reusable widget to build music cards
  Widget _buildMusicCard(dynamic song) {
    return GestureDetector(
      onTap: () {
        // Navigate to the CustomMusicPlayer when the card is tapped
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CustomMusicPlayer(
              trackName: song['Track Name'] ?? 'Unknown Track',
              artistName: song['Artist Name(s)'] ?? 'Unknown Artist',
              albumArtUrl: song['Album Image URL'] ?? 'https://via.placeholder.com/150',
              trackUrl: song['Track URL'], // Ensure this points to the correct audio link
              trackDuration: song['Track Duration (ms)'], // Pass the track duration, if available
            ),
          ),
        );
      },
      child: Container(
        width: 150, // Width of each card
        decoration: BoxDecoration(
          color: Color(0xFF3F3F3F),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 120,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
                image: DecorationImage(
                  image: NetworkImage(song['Album Image URL'] ?? 'https://via.placeholder.com/150'), // Dynamic image URL
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                song['Track Name'] ?? 'Unknown Track', // Dynamic track name
                style: TextStyle(color: Colors.white, fontSize: 14),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(
                song['Artist Name(s)'] ?? 'Unknown Artist', // Dynamic artist name
                style: TextStyle(color: Colors.white70, fontSize: 12),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
