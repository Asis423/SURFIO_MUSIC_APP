import 'dart:ui'; // Import for BackdropFilter
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

class CustomMusicPlayer extends StatefulWidget {
  final String trackName;
  final String artistName;
  final String albumArtUrl;
  final String trackUrl; // Track URL to play
  final int trackDuration; // Duration in milliseconds
  final double blurRadius; // Radius for the blur effect

  CustomMusicPlayer({
    required this.trackName,
    required this.artistName,
    required this.albumArtUrl,
    required this.trackUrl,
    required this.trackDuration,
    this.blurRadius = 10.0, // Default blur radius
  });

  @override
  _CustomMusicPlayerState createState() => _CustomMusicPlayerState();
}

class _CustomMusicPlayerState extends State<CustomMusicPlayer> {
  late AudioPlayer _audioPlayer;
  bool isPlaying = false;

  @override
  void initState() {
    super.initState();
    _audioPlayer = AudioPlayer();
    _playMusic();
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  // Play the music using the Track URL
  void _playMusic() async {
    try {
      await _audioPlayer.setUrl(widget.trackUrl);
      _audioPlayer.play();
      setState(() {
        isPlaying = true;
      });
    } catch (e) {
      print("Error loading audio: $e");
      // Optionally show a dialog or a SnackBar to inform the user about the error
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error loading audio: $e")),
      );
    }
  }

  // Toggle between play and pause
  void _togglePlayPause() {
    if (isPlaying) {
      _audioPlayer.pause();
    } else {
      _audioPlayer.play();
    }
    setState(() {
      isPlaying = !isPlaying;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack( // Added Stack to overlay elements
        children: [
          // Existing Container with gradient background
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color(0xFF190000), // Dark maroon red
                  Color(0xFF0F0019), // Dark purple
                ],
                stops: [0.0, 1.0],
              ),
            ),
          ),
          // Background image with opacity
          Opacity(
            opacity: 0.4, // Change this value to adjust opacity
            child: Image.network(
              widget.albumArtUrl, // Background album art URL
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
            ),
          ),
          // Hazy blur effect above the background
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: widget.blurRadius, sigmaY: widget.blurRadius),
            child: Container(
              color: Colors.black87.withOpacity(0.1), // Semi-transparent overlay
            ),
          ),
          // Main content on top of the gradient and image
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              // Top bar with back and menu buttons
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 40.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      icon: Icon(Icons.arrow_back_ios, color: Colors.white),
                      onPressed: () {
                        Navigator.pop(context); // Go back when clicked
                      },
                    ),
                    Icon(Icons.more_vert, color: Colors.white),
                  ],
                ),
              ),

              // Album artwork with gradient border
              SizedBox(height: 25,),
              Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    colors: [Colors.red[900]!, Colors.purple[900]!],
                  ),
                ),
                child: CircleAvatar(
                  radius: 110,
                  backgroundImage: NetworkImage(widget.albumArtUrl), // Album art passed from previous screen
                ),
              ),

              SizedBox(height: 75),

              // Song and artist name
              Column(
                children: [
                  Text(
                    widget.trackName, // Track name passed from previous screen
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    widget.artistName, // Artist name passed from previous screen
                    style: TextStyle(
                      color: Colors.white60,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),

              SizedBox(height: 25),

              // Music slider (progress bar)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: StreamBuilder<Duration>(
                  stream: _audioPlayer.positionStream,
                  builder: (context, snapshot) {
                    final position = snapshot.data ?? Duration.zero;
                    final total = _audioPlayer.duration ?? Duration(milliseconds: widget.trackDuration);
                    return Column(
                      children: [
                        Slider(
                          value: position.inSeconds.toDouble(),
                          min: 0,
                          max: total.inSeconds.toDouble(),
                          onChanged: (value) {
                            _audioPlayer.seek(Duration(seconds: value.toInt()));
                          },
                          activeColor: Colors.purple,
                          inactiveColor: Colors.white30,
                        ),
                        // Padding added to the duration texts
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0), // Adjust vertical padding as needed
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "${position.inMinutes}:${(position.inSeconds % 60).toString().padLeft(2, '0')}",
                                style: TextStyle(color: Colors.white),
                              ),
                              Text(
                                "${total.inMinutes}:${(total.inSeconds % 60).toString().padLeft(2, '0')}",
                                style: TextStyle(color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),

              SizedBox(height: 30),

              // Music controls (previous, play/pause, next)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Icon(Icons.shuffle, color: Colors.white38), // Shuffle icon
                  Icon(Icons.skip_previous, color: Colors.white, size: 30), // Previous track
                  Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                    ),
                    child: IconButton(
                      icon: Icon(isPlaying ? Icons.pause : Icons.play_arrow),
                      color: Colors.black,
                      iconSize: 50,
                      onPressed: _togglePlayPause, // Toggle play/pause
                    ),
                  ),
                  Icon(Icons.skip_next, color: Colors.white, size: 30), // Next track
                  Icon(Icons.repeat, color: Colors.white38), // Repeat icon
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
