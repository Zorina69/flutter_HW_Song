import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_song/model/songs/song.dart';
import 'package:test_song/ui/screens/library/view_model/library_view_model.dart';
import 'package:test_song/ui/states/settings_state.dart';
import 'package:test_song/ui/theme/theme.dart';

class LibraryContent extends StatelessWidget {
  const LibraryContent({super.key});

  @override
  Widget build(BuildContext context) {
    // watch the library view model
    LibraryViewModel viewModel = context.watch<LibraryViewModel>();

    // Watch the app setting state for theme
    AppSettingsState settingsState = context.watch<AppSettingsState>();

    return Scaffold(
      backgroundColor: settingsState.theme.backgroundColor,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 16),
          Text("Library", style: AppTextStyles.heading),

          SizedBox(height: 50),

          Text(
            "Your recent Song",
            style: TextStyle(color: AppColors.neutralLight),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: viewModel.songs.length,
              itemBuilder: (context, index) => SongTile(
                song: viewModel.songs[index],
                isPlaying: viewModel.isSongPlaying(viewModel.songs[index]),
                onTap: () {
                  viewModel.play(viewModel.songs[index]);
                },
                onStop: () {
                  viewModel.stop();
                },
              ),
            ),
          ),

          Text(
            "You might also like",
            style: TextStyle(color: AppColors.neutralLight),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: viewModel.songs.length,
              itemBuilder: (context, index) => SongTile(
                song: viewModel.songs[index],
                isPlaying: viewModel.isSongPlaying(viewModel.songs[index]),
                onTap: () {
                  viewModel.play(viewModel.songs[index]);
                },
                onStop: () {
                  viewModel.stop();
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
