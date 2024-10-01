import 'package:flutter/material.dart';
import 'ui/landing_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
<<<<<<< HEAD
import 'ui/player_trash.dart';
=======
// import 'ui/player_trash.dart';
>>>>>>> a3741b2fa2019b9d61d6c85042ebf3b16d811730
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
