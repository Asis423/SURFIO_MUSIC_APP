import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert'; // For JSON decoding
import '../player/music_player.dart'; // Import your music player

class QuickPicks extends StatefulWidget {
  QuickPicks();

  @override
  _QuickPicksState createState() => _QuickPicksState();
}

class _QuickPicksState extends State<QuickPicks> {
  List<dynamic> quickPicks = []; // List to hold the quick picks
  bool isLoading = true; // Loading state
  bool isError = false; // Error state

  @override
  void initState() {
    super.initState();
    _fetchQuickPicks(); // Fetch the songs when the widget initializes
  }

  Future<void> _fetchQuickPicks() async {
    final url = 'http://192.168.2.7:8000/music/quick_picks'; // Replace with your backend URL
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          quickPicks = data['quick_picks']; // Adjust according to your response structure
          isLoading = false; // Stop loading
          isError = false;
        });
      } else {
        setState(() {
          isLoading = false; // Stop loading on error
          isError = true; // Mark as error
        });
      }
    } catch (e) {
      setState(() {
        isLoading = false; // Stop loading on error
        isError = true; // Mark as error
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Quick Picks',
            style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10), // Add some spacing after the title
          Container(
            height: 218, // Adjust height of the container
            child: isLoading
                ? Center(child: CircularProgressIndicator()) // Show loading spinner while fetching
                : isError
                ? Center(child: Text('Failed to load songs', style: TextStyle(color: Colors.white)))
                : quickPicks.isEmpty
                ? Center(child: Text('No songs available', style: TextStyle(color: Colors.white)))
                : SingleChildScrollView(
              scrollDirection: Axis.horizontal, // Horizontal scrolling
              child: Row(
                children: _buildMusicColumns(), // Build dynamic columns
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Function to build dynamic columns with 3 songs per column
  List<Widget> _buildMusicColumns() {
    List<Widget> columns = [];
    int totalSongs = quickPicks.length;

    // Loop through and build columns
    for (int i = 0; i < totalSongs; i += 3) {
      // Sublist for songs in this column, ensures we don't go out of range
      List<dynamic> songsInColumn = quickPicks.sublist(i, (i + 3) > totalSongs ? totalSongs : (i + 3));

      columns.add(
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: songsInColumn.map((song) => _buildMusicTile(song)).toList(),
        ),
      );

      columns.add(SizedBox(width: 5)); // Increase the space between columns
    }
    return columns;
  }

  // Reusable widget to build ListTile style music items
  Widget _buildMusicTile(dynamic song) {
    return Container(
      width: 300, // Reduced the width of the tile for smaller size
      margin: const EdgeInsets.all(0.0), // Margin between tiles
      child: ListTile(
        contentPadding: EdgeInsets.only(right: 10), // Padding between song title and trailing icon
        leading: song['Album Image URL'] != null
            ? Image.network(
          song['Album Image URL'],
          width: 45, // Reduced image size
          height: 45,
          fit: BoxFit.cover,
        )
            : SizedBox(width: 45, height: 45), // Placeholder if no image
        title: Text(
          song['Track Name'] ?? 'Unknown Track',
          style: TextStyle(color: Colors.white, fontSize: 15), // Adjusted font size
          maxLines: 1, // Limit to 1 line
          overflow: TextOverflow.ellipsis, // Add ellipsis if text is too long
        ),
        subtitle: Text(
          song['Artist Name(s)'] ?? 'Unknown Artist',
          style: TextStyle(color: Colors.grey, fontSize: 13), // Adjusted font size
        ),
        trailing: Padding(
          padding: const EdgeInsets.only(right: 15.0), // Added padding to increase gap from song name
          child: GestureDetector(
            child: Icon(Icons.more_vert, color: Colors.purple.shade50, size: 18), // Reduced icon size
            onTap: () {
              _showBottomSheet(context, song);
            },
          ),
        ),
        onTap: () => _navigateToMusicPlayer(context, song), // Navigate to custom music player on tap
      ),
    );
  }

  // Example function to show bottom sheet
  void _showBottomSheet(BuildContext context, dynamic song) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: EdgeInsets.all(0.0),
          child: Text(
            'Actions for ${song['Track Name'] ?? 'Unknown Track'}',
            style: TextStyle(color: Colors.black),
          ),
        );
      },
    );
  }

  // Example function to navigate to the music player
  void _navigateToMusicPlayer(BuildContext context, dynamic song) {
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
  }
}
