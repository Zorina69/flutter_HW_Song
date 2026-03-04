import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_song/data/repositories/songs/song_repository.dart';
import 'package:test_song/model/songs/song.dart';
import 'package:test_song/ui/states/player_state.dart';
import 'package:test_song/ui/states/settings_state.dart';
import 'package:test_song/ui/theme/theme.dart';

class LibraryContent extends StatelessWidget {
  const LibraryContent({super.key});

  @override
  Widget build(BuildContext context) {
    // 1- Read the globbal song repository
    SongRepository songRepository = context.read<SongRepository>();
    List<Song> songs = songRepository.fetchSongs();

    // 2- Read the globbal settings state
    AppSettingsState settingsState = context.read<AppSettingsState>();

    // 3 - Watch the globbal player state
    PlayerState playerState = context.watch<PlayerState>();

    return Container(
      color: settingsState.theme.backgroundColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 16),
          Text("Library", style: AppTextStyles.heading),

          SizedBox(height: 50),

          Expanded(
            child: ListView.builder(
              itemCount: songs.length,
              itemBuilder: (context, index) => SongTile(
                song: songs[index],
                isPlaying: playerState.currentSong == songs[index],
                onTap: () {
                  playerState.start(songs[index]);
                },
                onStop: () {
                  playerState.stop();
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class SongTile extends StatelessWidget {
  const SongTile({
    super.key,
    required this.song,
    required this.isPlaying,
    required this.onTap,
    required this.onStop,
  });

  final Song song;
  final bool isPlaying;
  final VoidCallback onTap;
  final VoidCallback onStop;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      title: Text(song.title),
      trailing: Row(
        mainAxisSize: MainAxisSize.min, // ✅ FIX HERE
        children: [
          if (isPlaying)
            const Text("Playing", style: TextStyle(color: Colors.amber)),

          if (isPlaying)
            TextButton(
              onPressed: onStop,
              child: const Text("Stop", style: TextStyle(color: Colors.red)),
            ),
        ],
      ),
    );
  }
}
