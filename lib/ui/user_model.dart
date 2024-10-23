import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String id;
  final String username;
  final String email;
  final String? password; // Optional field for password

  UserModel({
    required this.id,
    required this.username,
    required this.email,
    this.password, // Initialize password as optional
  });

  factory UserModel.fromDocument(DocumentSnapshot doc) {
    return UserModel(
      id: doc.id,
      username: doc['username'],
      email: doc['email'],
      // You can choose to not include the password field in the model
      password: doc['password'], // Keep password as null when fetching from Firestore
    );
  }
}