import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:surfio_music_app/ui/login/login_page.dart';
import 'package:surfio_music_app/ui/user_model.dart';

class AdminDashboard extends StatefulWidget {
  @override
  _AdminDashboardState createState() => _AdminDashboardState();
}

class _AdminDashboardState extends State<AdminDashboard> with SingleTickerProviderStateMixin {
  String? username;
  String? email;
  List<UserModel> users = []; // List to hold users

  @override
  void initState() {
    super.initState();
    _fetchUserDetails();
    _fetchAllUsers(); // Fetch all users on initialization
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

  Future<void> _fetchAllUsers() async {
    QuerySnapshot snapshot = await FirebaseFirestore.instance.collection('users').get();
    setState(() {
      users = snapshot.docs.map((doc) => UserModel.fromDocument(doc)).toList();
    });
  }

  Future<void> _deleteUser(String userId) async {
    await FirebaseFirestore.instance.collection('users').doc(userId).delete();
    _fetchAllUsers(); // Refresh the user list after deletion
  }

  @override
  void dispose() {
    super.dispose();
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
              Builder(
                builder: (context) => IconButton(
                  icon: Icon(Icons.menu, color: Colors.white),
                  onPressed: () {
                    Scaffold.of(context).openDrawer(); // Open the drawer
                  },
                ),
              ),
              SizedBox(width: 10),
              Center(
                child: Text(
                  'Admin Dashboard', // Add title here
                  style: TextStyle(color: Colors.white, ), // White text for the title
                ),
              ),
            ],
          ),
        ),
      ),
      drawer: _buildDrawer(), // Drawer widget
      body: _buildUsersContent(), // Display the user list here
    );
  }

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
              ),
              accountEmail: Text(
                email ?? 'Loading...',
                style: TextStyle(color: Colors.white), // White text
              ),
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

  Widget _buildUsersContent() {
    return Container(
      color: Color(0xFF232323),
      child: ListView.builder(
        itemCount: users.length,
        itemBuilder: (context, index) {
          UserModel user = users[index];
          return ListTile(
            title: Text(user.username, style: TextStyle(color: Colors.white)),
            subtitle: Text(user.email, style: TextStyle(color: Colors.grey)),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: Icon(Icons.edit, color: Colors.blue),
                  onPressed: () {
                    _showEditUserDialog(user);
                  },
                ),
                IconButton(
                  icon: Icon(Icons.delete, color: Colors.red),
                  onPressed: () {
                    _showDeleteConfirmationDialog(user.id);
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  void _showEditUserDialog(UserModel user) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        String newUsername = user.username;
        String newEmail = user.email;
        String newPassword = ''; // Initialize a new password variable

        return AlertDialog(
          title: Text('Edit User'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: TextEditingController(text: newUsername),
                decoration: InputDecoration(labelText: 'Username'),
                onChanged: (value) {
                  newUsername = value;
                },
              ),
              TextField(
                controller: TextEditingController(text: newEmail),
                decoration: InputDecoration(labelText: 'Email'),
                readOnly: true, // Make the email field read-only
              ),
              TextField(
                controller: TextEditingController(), // Use an empty controller for password
                decoration: InputDecoration(labelText: 'Password (leave blank to keep current)'),
                onChanged: (value) {
                  newPassword = value; // Capture the new password
                },
                obscureText: true, // Hide password input
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                // Update user details
                Map<String, dynamic> updates = {
                  'username': newUsername,
                };

                // If a new password is provided, add it to updates
                if (newPassword.isNotEmpty) {
                  updates['password'] = newPassword; // Assume you handle password hashing in your UserModel or in backend
                }

                FirebaseFirestore.instance.collection('users').doc(user.id).update(updates).then((_) {
                  Navigator.of(context).pop(); // Close the dialog
                  _fetchAllUsers(); // Refresh the user list
                });
              },
              child: Text('Save'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text('Cancel'),
            ),
          ],
        );
      },
    );
  }

  void _showDeleteConfirmationDialog(String userId) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirm Deletion'),
          content: Text('Are you sure you want to delete this user?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () async {
                await _deleteUser(userId); // Delete user
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text('Delete'),
            ),
          ],
        );
      },
    );
  }

  Widget _buildSettingsContent() {
    return Container(
      color: Color(0xFF232323),
      child: Center(
        child: Text(
          'Settings Content Here',
          style: TextStyle(color: Colors.white), // Example content
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