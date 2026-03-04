import 'package:flutter/material.dart';
import 'package:test_song/data/repositories/songs/song_repository.dart';
import 'package:test_song/model/songs/song.dart';
import 'package:test_song/ui/states/player_state.dart';

class LibraryViewModel extends ChangeNotifier {
  final SongRepository songRepository;
  final PlayerState playerState;

  List<Song> _songs = [];
  LibraryViewModel({required this.songRepository, required this.playerState}) {
    playerState.addListener(_onPlayerStateChanged);
  }

  List<Song> get songs => _songs;
  Song? get currentSong => playerState.currentSong;
  bool get isPlaying => playerState.currentSong != null;

  bool isSongPlaying(Song song) {
    return playerState.currentSong?.id == song.id;
  }

  //Initialize and fetch song
  Future<void> init() async{
    _songs = songRepository.fetchSongs();
    notifyListeners();
  }
  // User Actions
  void play(Song song) {
    playerState.start(song);
  }

  void stop() {
    playerState.stop();
  }

  void togglePlayPause(Song song) {
    if (isSongPlaying(song)) {
      stop();
    } else {
      play(song);
    }
  }

  // Listen to PlayerState changes
  void _onPlayerStateChanged() {
    notifyListeners();
  }

  @override
  void dispose() {
    playerState.removeListener(_onPlayerStateChanged);
    super.dispose();
  }
}
