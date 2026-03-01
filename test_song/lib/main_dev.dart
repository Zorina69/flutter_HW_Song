import 'package:provider/provider.dart';
import 'package:nested/nested.dart';
import 'package:test_song/data/app_setting_repository.dart';
import 'package:test_song/data/app_setting_repository_mock.dart';
import 'main_common.dart';
import 'data/repositories/songs/song_repository.dart';
import 'data/repositories/songs/song_repository_mock.dart';
import 'ui/states/player_state.dart';
import 'ui/states/settings_state.dart';

/// Configure provider dependencies for dev environment
List<SingleChildWidget> get devProviders {
  return [
    // 1 - Inject the song repository
    Provider<SongRepository>(create: (_) => SongRepositoryMock()),

    // 2 - Inject the app settings repository
    Provider<AppSettingsRepository>(create: (_) => AppSettingsRepositoryMock()),

    // 3 - Inject the player state
    ChangeNotifierProvider<PlayerState>(create: (_) => PlayerState()),

    // 4 - Inject the app setting state (needs repository)
    ChangeNotifierProvider<AppSettingsState>(
      create: (context) =>
          AppSettingsState(context.read<AppSettingsRepository>())..init(),
    ),
  ];
}

void main() {
  mainCommon(devProviders);
}
