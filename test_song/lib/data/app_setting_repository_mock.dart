import 'package:test_song/data/app_setting_repository.dart';
import 'package:test_song/model/settings/app_settings.dart';

class AppSettingsRepositoryMock implements AppSettingsRepository {
  AppSettings _settings = AppSettings(themeColor: ThemeColor.blue);

  @override
  Future<AppSettings> load() async {
    return _settings;
  }

  @override
  Future<void> save(AppSettings settings) async {
    _settings = settings;
  }
}
