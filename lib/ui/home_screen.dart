import 'package:flutter/material.dart';
import 'popular_screen.dart';  // Import your screens
import 'latest_screen.dart';
import 'artists_screen.dart';
import 'genres_screen.dart';
import 'albums_screen.dart';
import 'search_screen.dart'; // For search functionality

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 6, // The number of tabs (Home, Popular, etc.)
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xFF232323), // Updated background color
          elevation: 0,
          automaticallyImplyLeading: false, // Remove the back button
          title: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                // Hamburger icon for menu/navigation drawer
                Icon(Icons.menu, color: Colors.white),
                SizedBox(width: 10),
                // Search bar container
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      // Navigate to search screen when tapped
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => SearchScreen()),
                      );
                    },
                    child: Container(
                      height: 35,
                      decoration: BoxDecoration(
                        color: Color(0xFF3F3F3F), // Updated search bar color
                        borderRadius: BorderRadius.circular(30),
                      ),
                      padding: EdgeInsets.symmetric(horizontal: 12),
                      child: Row(
                        children: [
                          Icon(Icons.search, color: Colors.grey), // Search icon
                          SizedBox(width: 10),
                          Expanded(
                            child: Text(
                              'Search songs, albums and artists', // Placeholder text
                              style: TextStyle(color: Colors.grey, fontSize: 14), // Small text
                              overflow: TextOverflow.ellipsis, // Handle overflow
                            ),
                          ),
                          Icon(Icons.tune, color: Colors.grey), // Filter icon
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          // TabBar for switching between Home, Popular, etc.
          bottom: TabBar(
            isScrollable: false, // Fixed position, not scrollable
            indicatorColor: Colors.purple, // Highlight color for selected tab
            labelColor: Colors.white, // Color of the selected tab text
            unselectedLabelColor: Color(0xFFAFAFAF), // Color of unselected tab text
            labelStyle: TextStyle(fontSize: 13), // Style for selected tab text
            unselectedLabelStyle: TextStyle(fontSize: 11), // Style for unselected tab text
            indicatorPadding: EdgeInsets.symmetric(horizontal: 8.0), // Adjust indicator padding
            labelPadding: EdgeInsets.symmetric(horizontal: 8.0), // Adjust tab padding
            tabs: [
              _buildTab('Home'),
              _buildTab('Popular'),
              _buildTab('Latest'),
              _buildTab('Artists'),
              _buildTab('Genres'),
              _buildTab('Albums'),
            ],
          ),
        ),
        // Each tab's content is displayed in this TabBarView
        body: TabBarView(
          children: [
            Container( // Simple placeholder for Home
              color: Color(0xFF232323), // Updated background color
              child: Center(
                child: Text(
                  'Home Screen Content',
                  style: TextStyle(color: Colors.white, fontSize: 24),
                ),
              ),
            ),
            PopularScreen(),  // Ensure these screens are implemented in respective files
            LatestScreen(),
            ArtistsScreen(),
            GenresScreen(),
            AlbumsScreen(),
          ],
        ),
      ),
    );
  }

  Widget _buildTab(String text) {
    return Tab(
      child: Align(
        alignment: Alignment.center,
        child: Text(text),
      ),
    );
  }
}
