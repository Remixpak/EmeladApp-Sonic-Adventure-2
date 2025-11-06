import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesService {

  Future<void> saveSelectedSong(String song) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('selectedSong', song);
  }

  Future<String> getSelectedSong() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('selectedSong') ??
        'main_theme'; 
  }

  Future<void> saveSoundEnabled(bool isEnabled) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('soundEnabled', isEnabled);
  }

  Future<bool> getSoundEnabled() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool('soundEnabled') ?? true;
  }

  Future<void> saveLoopSingleSong(bool loopSingle) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('loopSingleSong', loopSingle);
  }
  Future<bool> getLoopSingleSong() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool('loopSingleSong') ?? false;
  }

  Future<void> saveLoopAllSongs(bool loopAll) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('loopAllSongs', loopAll);
  }
  Future<bool> getLoopAllSongs() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool('loopAllSongs') ?? false;
  }
  /*static Future<void> saveDarkMode(bool isDarkMode) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isDarkMode', isDarkMode);
  }*/

  /*static Future<bool> getDarkMode() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool('isDarkMode') ?? false; // Valor por defecto false
  }*/
}
