import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:emerald_app_sonic_adventure_2/services/sharedPreferenceService.dart';

class AppData extends ChangeNotifier {
  final SharedPreferencesService _prefsService = SharedPreferencesService();
  final AudioPlayer _audioPlayer = AudioPlayer();

  String _selectedSong = "main_theme";
  bool _isDarkMode = false;
  bool _isSoundEnabled = true;
  bool _loopSingleSong = false;
  bool _loopAllSongs = false;
  int _currentSongIndex = 0;

  final List<String> _songs = ["main_theme", "knuckles_theme", "rouge_theme"];

  AppData() {
    loadData();
  }

  // --- Getters ---
  String get selectedSong => _selectedSong;
  bool get isDarkMode => _isDarkMode;
  bool get isSoundEnabled => _isSoundEnabled;
  bool get loopSingleSong => _loopSingleSong;
  bool get loopAllSongs => _loopAllSongs;

  // --- Load saved preferences ---
  Future<void> loadData() async {
    _selectedSong = await _prefsService.getSelectedSong();
    notifyListeners();
  }

  // --- Play/Stop Music ---
  Future<void> playMusic() async {
    if (!_isSoundEnabled) return;
    await _audioPlayer.stop();
    await _audioPlayer.play(AssetSource('sounds/$_selectedSong.mp3'));
    _audioPlayer.setReleaseMode(ReleaseMode.stop);
  }

  Future<void> playSingleSongLoop() async {
    if (!_isSoundEnabled) return;
    await _audioPlayer.stop();
    await _audioPlayer.play(AssetSource('sounds/$_selectedSong.mp3'));
    _audioPlayer.setReleaseMode(ReleaseMode.loop);
  }

  Future<void> playAllSongsLoop() async {
    if (!_isSoundEnabled) return;

    await _audioPlayer.stop();
    _currentSongIndex = 0;
    _audioPlayer.setReleaseMode(ReleaseMode.stop);

    _audioPlayer.onPlayerComplete.listen((_) async {
      if (!_loopAllSongs) return;
      _currentSongIndex = (_currentSongIndex + 1) % _songs.length;
      await _audioPlayer.play(
        AssetSource('sounds/${_songs[_currentSongIndex]}.mp3'),
      );
    });

    await _audioPlayer.play(
      AssetSource('sounds/${_songs[_currentSongIndex]}.mp3'),
    );
  }

  void stopMusic() => _audioPlayer.stop();

  // --- Setters ---
  Future<void> setSelectedSong(String song) async {
    _selectedSong = song;
    await _prefsService.saveSelectedSong(song);
    notifyListeners();
  }

  void setDarkMode(bool value) {
    _isDarkMode = value;
    notifyListeners();
  }

  void setSoundEnabled(bool value) {
    _isSoundEnabled = value;
    if (!value) stopMusic();
    notifyListeners();
  }

  void setLoopSingleSong(bool value) {
    _loopSingleSong = value;
    if (value) {
      _loopAllSongs = false;
      playSingleSongLoop();
    } else {
      _audioPlayer.setReleaseMode(ReleaseMode.stop);
    }
    notifyListeners();
  }

  void setLoopAllSongs(bool value) {
    _loopAllSongs = value;
    if (value) {
      _loopSingleSong = false;
      playAllSongsLoop();
    } else {
      _audioPlayer.setReleaseMode(ReleaseMode.stop);
    }
    notifyListeners();
  }
}
