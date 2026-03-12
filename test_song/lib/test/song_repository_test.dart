import '../data/repositories/songs/song_repository_mock.dart';

void main() async {
  //   Instantiate the  song_repository_mock
  final songs = SongRepositoryMock();

  // Test both the success and the failure of the post request

  // Handle the Future using 2 ways  (2 tests)
  // - Using then() with .catchError().
  print("test 1 (then() with catchError() = success");

  songs
      .fetchSongById("s1")
      .then((songs) => print("Found : ${songs?.title}"))
      .catchError((error) {
        print("Error : $error");
        return null;
      });

  print("test 2 (then() with catchError() - false");

  songs
      .fetchSongById("s100")
      .then((songs) => print("Found ${songs?.title}"))
      .catchError((error) {
        print("error :  $error");
        return null;
      });

  // - Using async/await with try/catch.
  await Future.delayed(const Duration(seconds: 4));

  print('Test 3 (async/await) - success:');

  try {
    final song = await songs.fetchSongById("s1");

    print("Found ${song?.title}");
  } catch (error) {
    print("error : $error");;
  }

  print('Test 4 (async/await) - Failure:');
  try {
    final song = await songs.fetchSongById("s1000");

    print("Found ${song?.title}");
  } catch (error) {
    print("error : $error");;
  }
}
