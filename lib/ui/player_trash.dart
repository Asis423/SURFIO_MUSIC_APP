import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

class AudioTestScreen extends StatefulWidget {
  @override
  _AudioTestScreenState createState() => _AudioTestScreenState();
}

class _AudioTestScreenState extends State<AudioTestScreen> {
  late AudioPlayer _audioPlayer;
  bool isPlaying = false;

  @override
  void initState() {
    super.initState();
    _audioPlayer = AudioPlayer();
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  Future<void> _playAudio() async {
    try {
      await _audioPlayer.setUrl('https://firebasestorage.googleapis.com/v0/b/surfio-417b9.appspot.com/o/music%2Ftwenty%20one%20pilots_%20Stressed%20Out%20[OFFICIAL%20VIDEO].mp3?alt=media');
      _audioPlayer.play();
      setState(() {
        isPlaying = true;
      });
    } catch (e) {
      print("Error loading audio: $e");
    }
  }

  Future<void> _stopAudio() async {
    await _audioPlayer.stop();
    setState(() {
      isPlaying = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Audio Test'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: isPlaying ? _stopAudio : _playAudio,
              child: Text(isPlaying ? 'Stop Audio' : 'Play Audio'),
            ),
          ],
        ),
      ),
    );
  }
}
