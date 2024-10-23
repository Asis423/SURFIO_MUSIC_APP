import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:surfio_music_app/ui/login/login_page.dart';
import 'package:surfio_music_app/ui/popular/popular_screen.dart';
import 'package:surfio_music_app/ui/recommend_screen.dart';
import 'package:surfio_music_app/ui/search_screen.dart';

import 'albums_screen.dart';
import 'artists_screen.dart';
import 'genres_screen.dart';
import 'home/latest.dart';
import 'home/popular.dart';
import 'home/quick_picks.dart';
import 'latest/latest_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int _selectedIndex = 0;

  String? username;
  String? email;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 6, vsync: this);
    _fetchUserDetails();
  }

  Future<void> _fetchUserDetails() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .get();

      if (userDoc.exists) {
        setState(() {
          username = userDoc['username'];
          email = userDoc['email'];
        });
      }
    }
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _onItemTapped(int index) {
    if (index == 0) {
      _tabController.animateTo(0);
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => RecommendScreen()),
      );
    }
    setState(() {
      _selectedIndex = index;
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
          padding: const EdgeInsets.all(0.0),
          child: Row(
            children: [
              Builder(
                builder: (context) => IconButton(
                  icon: Icon(Icons.menu, color: Colors.white),
                  onPressed: () {
                    Scaffold.of(context).openDrawer(); // Open the drawer
                  },
                ),
              ),
              SizedBox(width: 0),
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
                    padding: EdgeInsets.symmetric(horizontal: 8),
                    child: Row(
                      children: [
                        Icon(Icons.search, color: Colors.grey),
                        SizedBox(width: 2),
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
      drawer: _buildDrawer(), // Drawer widget
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildHomeContent(),
          PopularScreen(),
          LatestScreen(),
          ArtistsScreen(),
          GenresScreen(),
          AlbumsScreen(),
        ],
      ),
      bottomNavigationBar: Container(
        height: 70,
        child: BottomNavigationBar(
          backgroundColor: Color(0xFF171717),
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

  // Drawer widget with circular user image, username, email, and logout button
  Widget _buildDrawer() {
    return Drawer(
      child: Container(
        color: Color(0xFF232323), // Change drawer background color
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            UserAccountsDrawerHeader(
              decoration: BoxDecoration(color: Color(0xFF252525)),
              currentAccountPicture: CircleAvatar(
                child: Icon(Icons.person, color: Colors.white),
              ),
              accountName: Text(
                username ?? 'Loading...',
                style: TextStyle(color: Colors.white), // White text
              ), // Display fetched username
              accountEmail: Text(
                email ?? 'Loading...',
                style: TextStyle(color: Colors.white), // White text
              ), // Display fetched email
              onDetailsPressed: () {
                // Add functionality to change username
              },
            ),
            ListTile(
              leading: Icon(Icons.settings, color: Colors.white), // White icon
              title: Text('Settings', style: TextStyle(color: Colors.white)), // White text
              onTap: () {
                // Navigate to Settings page
              },
            ),
            ListTile(
              leading: Icon(Icons.playlist_play, color: Colors.white), // White icon
              title: Text('Playlist', style: TextStyle(color: Colors.white)), // White text
              onTap: () {
                // Navigate to Playlist page
              },
            ),
            ListTile(
              leading: Icon(Icons.library_music, color: Colors.white), // White icon
              title: Text('My Playlist', style: TextStyle(color: Colors.white)), // White text
              onTap: () {
                // Navigate to My Playlist page
              },
            ),
            ListTile(
              leading: Icon(Icons.logout, color: Colors.white), // White icon
              title: Text('Logout', style: TextStyle(color: Colors.white)), // White text
              onTap: () {
                _showLogoutConfirmationDialog();
              },
            ),
          ],
        ),
      ),
    );
  }

  void _showLogoutConfirmationDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirm Logout'),
          content: Text('Are you sure you want to log out?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () async {
                await FirebaseAuth.instance.signOut(); // Perform logout
                Navigator.of(context).pop(); // Close the dialog
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => LoginPage()), // Navigate to Login page
                );
              },
              child: Text('Confirm'),
            ),
          ],
        );
      },
    );
  }

  Widget _buildHomeContent() {
    return Container(
      color: Color(0xFF232323),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            QuickPicks(),
            SizedBox(height: 0),
            PopularSection(onSeeAll: () {
              _tabController.animateTo(1);
            }),
            SizedBox(height: 15),
            LatestSection(onSeeAll: () {
              _tabController.animateTo(2);
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