import 'package:flutter/material.dart';
import 'ui/landing_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
// import 'ui/player_trash.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
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
