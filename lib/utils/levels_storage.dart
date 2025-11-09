import 'dart:convert';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:emerald_app_sonic_adventure_2/models/levels.dart';

class LevelsStorage {
  /// Carga una lista de niveles según el personaje (ej: 'knuckles' o 'rouge')
  static Future<List<Level>> loadLevels(String character) async {
    final file = await _getLevelsFile(character);

    if (!await file.exists()) {
      final defaultLevels = _getDefaultLevels(character);
      await _saveLevels(file, defaultLevels);
      return defaultLevels;
    }

    final contents = await file.readAsString();
    final List<dynamic> jsonList = json.decode(contents);
    return jsonList.map((e) => Level.fromJson(e)).toList();
  }

  /// Guarda una lista de niveles (por si quieres persistir cambios)
  static Future<void> saveLevels(String character, List<Level> levels) async {
    final file = await _getLevelsFile(character);
    await _saveLevels(file, levels);
  }

  /// Crea o sobrescribe el archivo con los niveles dados
  static Future<void> _saveLevels(File file, List<Level> levels) async {
    final jsonString = json.encode(levels.map((e) => e.toJson()).toList());
    await file.writeAsString(jsonString);
  }

  /// Obtiene el archivo JSON correspondiente
  static Future<File> _getLevelsFile(String character) async {
    final dir = await getApplicationDocumentsDirectory();
    return File('${dir.path}/${character}_levels.json');
  }

  /// Devuelve la lista de niveles por defecto según el personaje
  static List<Level> _getDefaultLevels(String character) {
    switch (character) {
      case 'knuckles':
        return [
          Level(
            name: 'Wild Canyon',
            totalHints: 297,
            totalResults: 99,
            imageAsset: 'assets/images/knucklesLevels/wild_canyon_beta.png',
          ),
          Level(
            name: 'Pumpkin Hill',
            totalHints: 297,
            totalResults: 99,
            imageAsset: 'assets/images/knucklesLevels/pumpkin_hill_beta.jpeg',
          ),
          Level(
            name: 'Aquatic Mine',
            totalHints: 297,
            totalResults: 99,
            imageAsset: 'assets/images/knucklesLevels/aquatic_mine_beta.jpg',
          ),
          Level(
            name: 'Death Chamber',
            totalHints: 297,
            totalResults: 99,
            imageAsset: 'assets/images/knucklesLevels/death_chamber_beta.jpg',
          ),
          Level(
            name: 'Meteor Herd',
            totalHints: 297,
            totalResults: 99,
            imageAsset: 'assets/images/knucklesLevels/meteor_head_beta.jpg',
          ),
        ];

      case 'rouge':
        return [
          Level(
            name: 'Dry Lagoon',
            totalHints: 303,
            totalResults: 101,
            imageAsset: 'assets/images/rougeLevels/dry_lagoon_beta.png',
          ),
          Level(
            name: 'Egg Quarters',
            totalHints: 303,
            totalResults: 101,
            imageAsset: 'assets/images/rougeLevels/egg_quarters_beta.png',
          ),
          Level(
            name: 'Security Hall',
            totalHints: 324,
            totalResults: 108,
            imageAsset: 'assets/images/rougeLevels/security_hall_beta.png',
          ),
          Level(
            name: 'Mad Space',
            totalHints: 303,
            totalResults: 101,
            imageAsset: 'assets/images/rougeLevels/mad_space_beta.png',
          ),
        ];

      default:
        return [];
    }
  }
}
