import 'package:flutter/material.dart';
import 'ui/landing_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My App',
      debugShowCheckedModeBanner: false,
      home: LandingPage(), // Navigate to the home page
    );
  }
}