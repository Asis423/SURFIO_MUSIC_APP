import 'package:flutter/material.dart';
import 'login_page.dart'; // Make sure this import points to your login page file.
import 'signup_page.dart'; // Make sure this import points to your login page file.

class LoginInterface extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background gradient
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF4d0e02), Color(0xFF1b002e)],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
            ),
          ),
          // Main content
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0), // Decreased horizontal padding
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center, // Center items in the column
              children: [
                // Part 1: Logo and Title
                SizedBox(height: 100), // Top margin for the logo
                Image.asset(
                  'assets/images/logo_surfio.png', // Ensure this image path is correct
                  height: 90, // Adjust size as needed
                ),
                SizedBox(height: 20),
                Text(
                  'S U R F I O',
                  style: TextStyle(
                    fontWeight: FontWeight.w700, // Semi-bold style
                    fontSize: 26,
                    color: Colors.white, // Customize the text color
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 40),
                Text(
                  'Find Your Groove Here',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 60),

                // Part 2: Login Button (Transparent with stroke)
                Row(
                  mainAxisSize: MainAxisSize.min, // Use minimum size for the row
                  children: [
                    GestureDetector(
                      onTap: () {
                        // Navigate to login_page.dart
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => LoginPage()),
                        );
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 11, horizontal: 95), // Small padding
                        decoration: BoxDecoration(
                          color: Colors.transparent, // Make background transparent
                          border: Border.all(color: Colors.white, width: 2), // Add stroke
                          borderRadius: BorderRadius.circular(25.0),
                        ),
                        child: Text(
                          'LOGIN',
                          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700, color: Colors.white), // Text color white
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 15), // Space between buttons

                // Part 3: Sign Up Button (White background)
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SignupPage()),
                    );
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 11, horizontal: 87), // Small padding
                    decoration: BoxDecoration(
                      color: Colors.white, // White background
                      borderRadius: BorderRadius.circular(25.0),
                    ),
                    child: Text(
                      'SIGN UP',
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700, color: Colors.black), // Dark text color
                    ),
                  ),
                ),
                SizedBox(height: 15), // Space between buttons

                // Part 4: Google Login Button (White background)
                GestureDetector(
                  onTap: () {
                    // Handle Google login
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 12, horizontal: 35), // Small padding
                    decoration: BoxDecoration(
                      color: Colors.white, // White background
                      borderRadius: BorderRadius.circular(25.0),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min, // Shrink to fit
                      children: [
                        Image.asset(
                          'assets/images/ic_google.png', // Ensure this path is correct
                          height: 24,
                        ),
                        SizedBox(width: 5),
                        Text(
                          'Login With Google',
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: Colors.black), // Dark text color
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 20),

                Spacer(), // Pushes the social media login section to the bottom

                // Social Media section
                Text(
                  'Login with Social Media',
                  style: TextStyle(
                    fontWeight: FontWeight.w400, // Semi-bold style
                    fontSize: 18,
                    color: Colors.white, // Customize the text color
                  ),
                  textAlign: TextAlign.center, // Center the text
                ),
                SizedBox(height: 10),

                // Social Media icons
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      icon: Image.asset(
                        'assets/images/ic_instagram.png', // Ensure this path is correct
                        height: 30, // Adjust the size as needed
                      ),
                      onPressed: () {},
                    ),
                    SizedBox(width: 10), // Space between icons
                    IconButton(
                      icon: Image.asset(
                        'assets/images/ic_twitter.png', // Ensure this path is correct
                        height: 30, // Adjust the size as needed
                      ),
                      onPressed: () {},
                    ),
                    SizedBox(width: 10), // Space between icons
                    IconButton(
                      icon: Image.asset(
                        'assets/images/ic_facebook.png', // Ensure this path is correct
                        height: 30, // Adjust the size as needed
                      ),
                      onPressed: () {},
                    ),
                  ],
                ),
                SizedBox(height: 20), // Bottom margin
              ],
            ),
          ),
        ],
      ),
    );
  }
}
