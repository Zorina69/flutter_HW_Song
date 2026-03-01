

import 'package:test_song/model/settings/app_settings.dart';

abstract class AppSettingsRepository {
  Future<AppSettings> load();
  Future<void> save(AppSettings settings);
}
