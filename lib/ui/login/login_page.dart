import 'package:flutter/material.dart';
import 'package:surfio_music_app/ui/login/signup_page.dart';
import 'package:surfio_music_app/ui/home_screen.dart'; // Import your home screen
import 'package:firebase_auth/firebase_auth.dart'; // Import Firebase Auth package

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  String _email = '';
  String _password = '';
  final FirebaseAuth _auth = FirebaseAuth.instance; // Initialize Firebase Auth

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

          // Logo and "Login with your Account" text
          Positioned(
            top: 75,
            left: 0,
            right: 0,
            child: Column(
              children: [
                // Logo at the center
                Image.asset(
                  'assets/images/logo_surfio.png', // Replace with your logo path
                  width: 75, // Set the size as needed
                ),
                SizedBox(height: 40), // Space between logo and text
                // "Login with your Account" text below the logo
                Text(
                  'Login with your Account',
                  style: TextStyle(
                    fontWeight: FontWeight.w700, // Semi-bold style
                    fontSize: 25,
                    color: Colors.white, // Customize the text color
                  ),
                ),
              ],
            ),
          ),

          // White background with Email, Password fields, and Login button
          Padding(
            padding: const EdgeInsets.only(top: 275.0),
            child: Container(
              height: MediaQuery.of(context).size.height - 275,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40),
                  topRight: Radius.circular(40),
                ),
              ),
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(30.0), // Padding inside the white container
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // Email Field
                      Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            TextFormField(
                              decoration: InputDecoration(
                                labelText: 'Email',
                                labelStyle: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                    color: Color(0xFFbe0000)),
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Color(0xFF4d0e02)),
                                ),
                              ),
                              onChanged: (value) {
                                setState(() {
                                  _email = value;
                                });
                              },
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your email';
                                }
                                return null;
                              },
                            ),
                            SizedBox(height: 20),
                
                            // Password Field
                            TextFormField(
                              obscureText: true,
                              decoration: InputDecoration(
                                labelText: 'Password',
                                labelStyle: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                    color: Color(0xFFbe0000)),
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Color(0xFF4d0e02)),
                                ),
                              ),
                              onChanged: (value) {
                                setState(() {
                                  _password = value;
                                });
                              },
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your password';
                                }
                                return null;
                              },
                            ),
                            SizedBox(height: 50),
                
                            // Login Button with gradient and custom text
                            Container(
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [Color(0xff7d0000), Color(0xff28004b)],
                                  begin: Alignment.centerLeft,
                                  end: Alignment.centerRight,
                                ),
                                borderRadius: BorderRadius.circular(25),
                              ),
                              child: ElevatedButton(
                                onPressed: () async {
                                  if (_formKey.currentState!.validate()) {
                                    try {
                                      // Authenticate user with email and password
                                      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
                                        email: _email,
                                        password: _password,
                                      );
                
                                      // If login is successful, navigate to HomeScreen
                                      Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(builder: (context) => HomeScreen()),
                                      );
                                    } on FirebaseAuthException catch (e) {
                                      // Handle error (e.g., show a message)
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(content: Text(e.message ?? 'An error occurred')),
                                      );
                                    }
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 90, vertical: 12),
                                  backgroundColor: Colors.transparent, // No solid color, use gradient
                                  shadowColor: Colors.transparent, // Remove shadow
                                ),
                                child: Text(
                                  'LOGIN',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white, // White login text
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 25),
                
                            // Forgot Password Text
                            GestureDetector(
                              onTap: () {
                                // Handle forgot password action
                              },
                              child: Text(
                                'Forgot Password?',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Color(0xFF1b002e),
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                            ),
                
                            // Sign Up link with different colors for "Already have an account?" and "Sign Up"
                            SizedBox(height: 25),
                            GestureDetector(
                              onTap: () {
                                // Open the signup page
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => SignupPage()),
                                );
                              },
                              child: RichText(
                                text: TextSpan(
                                  text: 'Already have an account? ',
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Color(0xFF1b002e),
                                  ),
                                  children: <TextSpan>[
                                    TextSpan(
                                      text: 'Sign Up',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Color(0xFFbe0000), // "Sign Up" in red color
                                        decoration: TextDecoration.underline,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
