import 'package:flutter/material.dart';
import 'home/latest.dart';
import 'home/popular.dart';
import 'popular_screen.dart';
import 'latest_screen.dart';
import 'artists_screen.dart';
import 'genres_screen.dart';
import 'albums_screen.dart';
import 'search_screen.dart';
import 'recommend_screen.dart'; // Create this screen for recommendations

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int _selectedIndex = 0; // Track the selected index for the bottom navigation

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 6, vsync: this); // Initialize the TabController
  }

  @override
  void dispose() {
    _tabController.dispose(); // Dispose the controller
    super.dispose();
  }

  void _onItemTapped(int index) {
    if (index == 0) {
      _tabController.animateTo(0); // Navigate to Home tab
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => RecommendScreen()), // Open the Recommend screen
      );
    }
    setState(() {
      _selectedIndex = index; // Update the selected index
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF252525),
        elevation: 0,
        automaticallyImplyLeading: false,
        title: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Icon(Icons.menu, color: Colors.white),
              SizedBox(width: 10),
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SearchScreen()),
                    );
                  },
                  child: Container(
                    height: 35,
                    decoration: BoxDecoration(
                      color: Color(0xFF3F3F3F),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 12),
                    child: Row(
                      children: [
                        Icon(Icons.search, color: Colors.grey),
                        SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            'Search songs, albums and artists',
                            style: TextStyle(color: Colors.grey, fontSize: 14),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Icon(Icons.tune, color: Colors.grey),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        bottom: TabBar(
          controller: _tabController,
          isScrollable: false,
          indicatorColor: Colors.purple,
          labelColor: Colors.white,
          unselectedLabelColor: Color(0xFFAFAFAF),
          labelStyle: TextStyle(fontSize: 13),
          unselectedLabelStyle: TextStyle(fontSize: 11),
          indicatorPadding: EdgeInsets.symmetric(horizontal: 8.0),
          labelPadding: EdgeInsets.symmetric(horizontal: 8.0),
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
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildHomeContent(), // Home content with popular and latest sections
          PopularScreen(), // The individual PopularScreen view
          LatestScreen(), // The individual LatestScreen view
          ArtistsScreen(), // Other tabs
          GenresScreen(),
          AlbumsScreen(),
        ],
      ),
      bottomNavigationBar: Container(
        height: 70, // Adjust this value to increase the height
        child: BottomNavigationBar(
          backgroundColor: Color(0xFF171717), // Darker black for bottom navigation
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
                color: _selectedIndex == 0 ? Colors.purple : Colors.white,
              ),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.recommend,
                color: _selectedIndex == 1 ? Colors.purple : Colors.white,
              ),
              label: 'Recommend',
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.purple,
          unselectedItemColor: Colors.white,
          onTap: _onItemTapped,
        ),
      ),
    );
  }

  // This method builds the home content with "Popular" and "Latest" sections
  Widget _buildHomeContent() {
    return Container(
      color: Color(0xFF232323),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            PopularSection(onSeeAll: () {
              _tabController.animateTo(1); // Switch to the Popular tab
            }),
            SizedBox(height: 25),
            LatestSection(onSeeAll: () {
              _tabController.animateTo(2); // Switch to the Latest tab
            }),
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
