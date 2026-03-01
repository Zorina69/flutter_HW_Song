import 'package:provider/provider.dart';
import 'package:test_song/data/repositories/songs/song_repository.dart';
import 'package:test_song/data/repositories/songs/song_repository_remote.dart';
import 'package:test_song/main_common.dart';

List<Provider> get providersLocal {
  return [
    Provider<SongRepository>(create: (context) => SongRepositoryRemote()),
  ];
}

void main() {
  mainCommon(providersLocal);
}
