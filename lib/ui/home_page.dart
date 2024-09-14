import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Add the background image here
          Image.asset(
            'assets/images/bg_home.jpg',
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),
          // Add other content on top of the background image
          Positioned(
            top: 100,
            child: Center(
              child: Text('Welcome to the Home Page'),
            ),
          ),
        ],
      ),
    );
  }
}