import 'package:flutter/material.dart';

class LatestScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Color(0xFF232323), // Set background color to match the rest of the app
        child: Center(
          child: Text(
            'All Latest Songs content goes here', // Placeholder content
            style: TextStyle(color: Colors.white, fontSize: 24),
          ),
        ),
      ),
    );
  }
}
