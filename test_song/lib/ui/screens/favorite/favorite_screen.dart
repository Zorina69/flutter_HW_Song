import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_song/model/songs/song.dart';
import '../../../data/repositories/songs/song_repository.dart';
import '../../states/player_state.dart';
import '../../states/settings_state.dart';
import '../../theme/theme.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // 1- Read the globbal song repository
    SongRepository songRepository = context.read<SongRepository>();
    List<Song> songs = songRepository.fetchSongs();

    // 3 - Watch the globbal player state
    PlayerState playerState = context.read<PlayerState>();

    // Watch the app settings state for theme
    AppSettingsState settingsState = context.watch<AppSettingsState>();

    return Scaffold(
      backgroundColor: settingsState.theme.backgroundColor,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 16),
          Text("Favorite", style: AppTextStyles.heading),

          SizedBox(height: 50),

          Expanded(
            child: ListView.builder(
              itemCount: songs.length,
              itemBuilder: (context, index) => SongTile(
                song: songs[index],
                isPlaying: playerState.currentSong == songs[index],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class SongTile extends StatelessWidget {
  const SongTile({super.key, required this.song, required this.isPlaying});

  final Song song;
  final bool isPlaying;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(song.title),
      trailing: Text(
        isPlaying ? "Playing" : "",
        style: TextStyle(color: Colors.amber),
      ),
    );
  }
}
