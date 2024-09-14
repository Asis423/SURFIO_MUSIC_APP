import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: GenreSelectionScreen(),
    );
  }
}

class GenreSelectionScreen extends StatefulWidget {
  @override
  _GenreSelectionScreenState createState() => _GenreSelectionScreenState();
}

class _GenreSelectionScreenState extends State<GenreSelectionScreen> {
  final List<String> _genres = [
    'Rock',
    'Pop',
    'Hip Hop',
    'Classical',
    'Jazz',
    'Electronic',
    'Country',
    'Reggae',
  ];

  // To track selected genres
  final Map<String, bool> _selectedGenres = {};

  @override
  void initState() {
    super.initState();
    // Initialize selectedGenres map with default values
    for (var genre in _genres) {
      _selectedGenres[genre] = false;
    }
  }

  void _submitSelection() {
    List<String> selectedGenres = _selectedGenres.keys
        .where((genre) => _selectedGenres[genre]!)
        .toList();

    if (selectedGenres.isNotEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Selected genres: ${selectedGenres.join(', ')}'),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('No genres selected'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Select Genre for Recommendation'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              'Choose your favorite genres:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: ListView(
              children: _genres.map((genre) {
                return CheckboxListTile(
                  title: Text(genre),
                  value: _selectedGenres[genre],
                  onChanged: (bool? selected) {
                    setState(() {
                      _selectedGenres[genre] = selected ?? false;
                    });
                  },
                );
              }).toList(),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: ElevatedButton(
              onPressed: _submitSelection,
              child: const Text('Get Recommendations'),
            ),
          ),
        ],
      ),
    );
  }
}
