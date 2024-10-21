import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert'; // For parsing JSON responses
import '../config.dart';
import 'home_screen.dart';
import 'recommended_songs.dart'; // Import the screen for recommended songs

class RecommendScreen extends StatefulWidget {
  @override
  _RecommendScreenState createState() => _RecommendScreenState();
}

class _RecommendScreenState extends State<RecommendScreen> {
  int _selectedIndex = 1; // The Recommend tab is selected
  TextEditingController _searchController = TextEditingController();

  Future<void> _fetchRecommendations(String query) async {
    final url = '${Config.baseUrl}/music/recommend?query=$query'; // Update with your backend URL
    try {
      print('Fetching recommendations for query: $query'); // Debug log
      final response = await http.get(Uri.parse(url));

      print('Response status: ${response.statusCode}'); // Debug log
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final recommendations = data['recommendations'];

        // Check if recommendations are not empty before navigating
        if (recommendations != null && recommendations.isNotEmpty) {
          // Navigate to RecommendedSongsScreen and pass recommendations
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => RecommendedSongsScreen(recommendations: recommendations, typedText: query), // Pass the typed query
            ),
          );
        } else {
          _showErrorDialog('No recommendations found for this query.');
        }
      } else {
        _showErrorDialog('Failed to load recommendations: ${response.reasonPhrase}');
      }
    } catch (e) {
      print('Caught error: $e'); // Debug log
      _showErrorDialog('Error: $e');
    }
  }

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
        color: Color(0xFF232323), // Same background color as HomeScreen
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            SizedBox(height: 40), // Spacing from the top, can adjust based on design
            Row(
              children: [
                Expanded(
                  child: Container(
                    height: 35,
                    decoration: BoxDecoration(
                      color: Color(0xFF3F3F3F),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      children: [
                        Icon(Icons.search, color: Colors.grey),
                        SizedBox(width: 8),
                        Expanded(
                          child: TextField(
                            controller: _searchController,
                            style: TextStyle(color: Colors.grey, fontSize: 14),
                            decoration: InputDecoration(
                              hintText: 'Search songs, albums and artists',
                              hintStyle: TextStyle(color: Colors.grey),
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.symmetric(vertical: 10), // Center the text vertically
                            ),
                            onSubmitted: (query) {
                              print('Query submitted: $query'); // Log the submitted query
                              FocusScope.of(context).unfocus(); // Dismiss the keyboard
                              if (query.isNotEmpty) {
                                _fetchRecommendations(query);
                              } else {
                                _showErrorDialog('Please enter a search term.');
                              }
                            },
                          ),
                        ),
                        Icon(Icons.tune, color: Colors.grey),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: SizedBox(
        height: 70, // Set the height here
        child: BottomNavigationBar(
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
      ),
    );
  }
}
