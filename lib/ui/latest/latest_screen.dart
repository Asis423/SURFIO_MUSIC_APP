import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert'; // To parse JSON data
import 'package:surfio_music_app/ui/player/music_player.dart';
import '../../config.dart';

class LatestScreen extends StatefulWidget {
  @override
  _LatestScreenState createState() => _LatestScreenState();
}

class _LatestScreenState extends State<LatestScreen> {
  List<dynamic> latestMusic = []; // This will hold the list of popular songs
  bool isLoading = true; // To show a loading indicator

  @override
  void initState() {
    super.initState();
    _fetchLatestSongs(); // Fetch popular songs when the screen is initialized
  }

  // Function to fetch popular songs from the backend
  Future<void> _fetchLatestSongs() async {
    final url = '${Config.baseUrl}/music/latest'; // Replace with your backend URL
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final data = json.decode(response.body); // Parse the response body
        setState(() {
          latestMusic = data['latest_music']; // Assign the popular songs list
          isLoading = false; // Set loading to false when data is loaded
        });
      } else {
        // If the server did not return a 200 OK response, throw an error.
        _showErrorDialog('Failed to load latest songs: ${response.reasonPhrase}');
      }
    } catch (e) {
      _showErrorDialog('Error: $e');
    }
  }

  // Function to show an error dialog
  void _showErrorDialog(String message) {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Color(0xFF232323),
        child: isLoading
            ? Center(child: CircularProgressIndicator()) // Show loading spinner while data is being fetched
            : Column(
          crossAxisAlignment: CrossAxisAlignment.start, // Align items to the start (left)
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0), // Padding around the text
              child: Text(
                'Latest Songs',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: latestMusic.length, // Number of popular songs
                itemBuilder: (context, index) {
                  final song = latestMusic[index];
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
                      maxLines: 1, // Limit to 1 line
                      overflow: TextOverflow.ellipsis, // Add ellipsis if text is too long
                    ),
                    subtitle: Text(
                      song['Artist Name(s)'],
                      style: TextStyle(color: Colors.grey),
                    ),
                    trailing: GestureDetector(
                      child: Icon(Icons.more_vert, color: Colors.purple.shade50),
                      onTap: () {
                        _showBottomSheet(context, song);
                      },
                    ),
                    onTap: () => _navigateToMusicPlayer(context, song), // Navigate to custom music player on tap
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Function to show the bottom sheet with song options
  void _showBottomSheet(BuildContext context, dynamic song) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Color(0xFF232323), // Set the background color to match the app theme
      builder: (BuildContext context) {
        return buildBottomSheetContent(context, song);
      },
    );
  }

  // Method to build the bottom sheet content
  Widget buildBottomSheetContent(BuildContext context, dynamic song) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            leading: Icon(Icons.play_circle_outline, color: Colors.white),
            title: Text('Play', style: TextStyle(color: Colors.white)),
            onTap: () {
              Navigator.pop(context); // Close the bottom sheet after selection
              _navigateToMusicPlayer(context, song); // Play the selected song
            },
          ),
          ListTile(
            leading: Icon(Icons.playlist_add, color: Colors.white),
            title: Text('Add to Playlist', style: TextStyle(color: Colors.white)),
            onTap: () {
              Navigator.pop(context); // Close the bottom sheet after selection
              // Add your functionality to add to playlist
            },
          ),
          ListTile(
            leading: Icon(Icons.info_outline, color: Colors.white),
            title: Text('View Details', style: TextStyle(color: Colors.white)),
            onTap: () {
              Navigator.pop(context); // Close the bottom sheet after selection
              // Add your functionality to view song details
            },
          ),
        ],
      ),
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
          trackDuration: song['Track Duration (ms)'], // Pass the Track Duration
        ),
      ),
    );
  }
}
