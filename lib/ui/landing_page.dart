import 'package:flutter/material.dart';
<<<<<<< HEAD
import 'home_screen.dart'; // Import the home_screen.dart file
=======
import 'login/login_interface.dart'; // Import the home_screen.dart file
>>>>>>> a3741b2fa2019b9d61d6c85042ebf3b16d811730

class LandingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background image
          Image.asset(
            'assets/images/bg_home.jpg',
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),
          // Logo and text centered at the top
          Positioned(
            top: 75,
            left: 0,
            right: 0,
            child: Column(
              children: [
                // Logo at the center
                Image.asset(
                  'assets/images/logo_surfio.png',
                  width: 75, // Set the size as needed
                ),
                SizedBox(height: 15), // Space between logo and text
                // "SURFIO" text below the logo
                Text(
                  'S U R F I O',
                  style: TextStyle(
                    fontWeight: FontWeight.w700, // Semi-bold style
                    fontSize: 22,
                    color: Colors.white, // Customize the text color
                  ),
                ),
              ],
            ),
          ),
          // Add two texts at the bottom middle
          Positioned(
            bottom: 60, // Adjust the distance from the bottom
            left: 0,
            right: 0,
            child: Column(
              children: [
                // First text
                Text(
                  'Explore songs tailored to your genre.',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                    fontWeight: FontWeight.w300,
                  ),
                ),
                SizedBox(height: 7), // Space between the two texts
                // Second text
                Text(
                  'GET STARTED NOW!',
                  style: TextStyle(
                    fontSize: 22,
                    color: Colors.white, // Slightly dimmed color
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 20), // Space between the text and the button image
                // Image as a button
                GestureDetector(
                  onTap: () {
                    // Navigate to home_screen.dart when button is clicked
                    Navigator.push(
                      context,
<<<<<<< HEAD
                      MaterialPageRoute(builder: (context) => HomeScreen()), // Ensure HomeScreen is implemented
=======
                      MaterialPageRoute(builder: (context) => LoginInterface()), // Ensure HomeScreen is implemented
>>>>>>> a3741b2fa2019b9d61d6c85042ebf3b16d811730
                    );
                  },
                  child: Image.asset(
                    'assets/images/bg_button.png', // Replace with the correct image for the button
                    width: 60, // Adjust the size as needed
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
