import 'package:provider/provider.dart';
import 'package:nested/nested.dart';
import 'package:test_song/ui/screens/library/view_model/library_view_model.dart';
import 'main_common.dart';
import 'data/repositories/settings/app_settings_repository_mock.dart';
import 'data/repositories/songs/song_repository.dart';
import 'data/repositories/songs/song_repository_mock.dart';
import 'ui/states/player_state.dart';
import 'ui/states/settings_state.dart';

/// Configure provider dependencies for dev environment
List<SingleChildWidget> get devProviders {
  final appSettingsRepository = AppSettingsRepositoryMock();

  return [
    // 1 - Inject the song repository
    Provider<SongRepository>(create: (_) => SongRepositoryMock()),

    // 2 - Inject the player state
    ChangeNotifierProvider<PlayerState>(create: (_) => PlayerState()),

    // 3 - Inject the  app setting state
    ChangeNotifierProvider<AppSettingsState>(
      create: (_) => AppSettingsState(repository: appSettingsRepository),
    ),

    // // 4 - Inject the app settings repository
    // Provider<AppSettingsRepository>(create: (_) => AppSettingsRepositoryMock()),
    
    // 5 - Inject the library view model (needs repository and player state)
    ChangeNotifierProvider<LibraryViewModel>(
      create: (context) => LibraryViewModel(
        songRepository: context.read<SongRepository>(),
        playerState: context.read<PlayerState>(),
      )..init(),
    ),
  ];
}

void main() {
  mainCommon(devProviders);
}
