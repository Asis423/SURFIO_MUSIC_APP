import 'package:flutter/material.dart';
import 'config.dart'; // Import the config file

class ApiConfig {
  static final ApiConfig _instance = ApiConfig._internal();

  String baseUrl = Config.baseUrl; // Use the static base URL

  factory ApiConfig() {
    return _instance;
  }

  ApiConfig._internal();

// Add methods to handle API calls here using baseUrl
}
