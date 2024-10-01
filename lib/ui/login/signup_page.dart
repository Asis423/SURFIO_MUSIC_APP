import 'package:flutter/material.dart';
import 'package:surfio_music_app/ui/login/login_page.dart';

class SignupPage extends StatefulWidget {
  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final _formKey = GlobalKey<FormState>();
  String _username = '';
  String _email = '';
  String _gender = 'Male'; // Default gender selection
  String _password = '';
  String _confirmPassword = '';

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

          // Logo and "Create a New Account" text
          Positioned(
            top: 60,
            left: 0,
            right: 0,
            child: Column(
              children: [
                // Logo at the center
                Image.asset(
                  'assets/images/logo_surfio.png', // Replace with your logo path
                  width: 75, // Set the size as needed
                ),
                SizedBox(height: 25), // Space between logo and text
                // "Create a New Account" text below the logo
                Text(
                  'Create a New Account',
                  style: TextStyle(
                    fontWeight: FontWeight.w700, // Semi-bold style
                    fontSize: 26,
                    color: Colors.white, // Customize the text color
                  ),
                ),
              ],
            ),
          ),

          // White background with fields and signup button
          Padding(
            padding: const EdgeInsets.only(top: 225.0),
            child: Container(
              height: MediaQuery.of(context).size.height - 100,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40),
                  topRight: Radius.circular(40),
                ),
              ),
              child: SingleChildScrollView( // Added scrollable container
                child: Padding(
                  padding: const EdgeInsets.all(25.0), // Padding inside the white container
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // Username, Email, Gender, Password, Confirm Password Fields
                      Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            // Username Field
                            TextFormField(
                              decoration: InputDecoration(
                                labelText: 'Username',
                                labelStyle: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: Color(0xFFbe0000)),
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Color(0xFF4d0e02)),
                                ),
                              ),
                              onChanged: (value) {
                                setState(() {
                                  _username = value;
                                });
                              },
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your username';
                                }
                                return null;
                              },
                            ),
                            SizedBox(height: 15),

                            // Email Field
                            TextFormField(
                              decoration: InputDecoration(
                                labelText: 'Email',
                                labelStyle: TextStyle(
                                    fontSize: 16,
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
                            SizedBox(height: 15),

                            // Gender Field
                            DropdownButtonFormField<String>(
                              value: _gender,
                              decoration: InputDecoration(
                                labelText: 'Gender',
                                labelStyle: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: Color(0xFFbe0000)),
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Color(0xFF4d0e02)),
                                ),
                              ),
                              items: ['Male', 'Female', 'Other'].map((String gender) {
                                return DropdownMenuItem<String>(
                                  value: gender,
                                  child: Text(gender),
                                );
                              }).toList(),
                              onChanged: (value) {
                                setState(() {
                                  _gender = value!;
                                });
                              },
                            ),
                            SizedBox(height: 15),

                            // Password Field
                            TextFormField(
                              obscureText: true,
                              decoration: InputDecoration(
                                labelText: 'Password',
                                labelStyle: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: Color(0xFFbe0000)),
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Color(0xFFbe0000)),
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
                            SizedBox(height: 15),

                            // Confirm Password Field
                            TextFormField(
                              obscureText: true,
                              decoration: InputDecoration(
                                labelText: 'Confirm Password',
                                labelStyle: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: Color(0xFFbe0000)),
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Color(0xFFbe0000)),
                                ),
                              ),
                              onChanged: (value) {
                                setState(() {
                                  _confirmPassword = value;
                                });
                              },
                              validator: (value) {
                                if (value == null || value != _password) {
                                  return 'Passwords do not match';
                                }
                                return null;
                              },
                            ),
                            SizedBox(height: 40),

                            // Sign Up Button with gradient and custom text
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
                                onPressed: () {
                                  if (_formKey.currentState!.validate()) {
                                    // Handle signup action
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 80, vertical: 12),
                                  backgroundColor: Colors.transparent, // No solid color, use gradient
                                  shadowColor: Colors.transparent, // Remove shadow
                                ),
                                child: Text(
                                  'SIGN UP',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white, // White signup text
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 25),

                            // Already have an Account? Login Text
                            GestureDetector(
                              onTap: () {
                                // Handle navigate to login
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => LoginPage()),
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
                                      text: 'Login',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Color(0xFFbe0000), // "Login" in red color
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
