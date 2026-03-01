import 'package:flutter/widgets.dart';
import 'package:test_song/model/songs/song.dart';

class PlayerState extends ChangeNotifier {
  Song? _currentSong;

  Song? get currentSong => _currentSong;

  void start(Song song) {
    _currentSong = song;

    notifyListeners();
  }

  void stop() {
    _currentSong = null;

    notifyListeners();
  }
}
