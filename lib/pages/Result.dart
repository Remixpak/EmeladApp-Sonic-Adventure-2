import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;
import 'package:crypto/crypto.dart';
import '../models/levels.dart';

class ResulScreen extends StatefulWidget {
  final String hint1;
  final String hint2;
  final String hint3;
  final Level level;

  ResulScreen({
    required this.hint1,
    required this.hint2,
    required this.hint3,
    required this.level,
  });

  @override
  _ResultScreenState createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResulScreen> {
  final ImagePicker _picker = ImagePicker();

  String? locationType;
  String? description;
  String? errorMessage;
  
  // Imagen local para ESTA pantalla específica (no compartida)
  Image? _localImageLocation;

  /// Genera un identificador único basado en los hints
  String _generateHintHash() {
    final hintsString = '${widget.hint1}|${widget.hint2}|${widget.hint3}';
    return hintsString.hashCode.toString().replaceAll('-', '');
  }

  @override
  void initState() {
    super.initState();
    _loadLevelData();
    _loadStoredImage();
  }

  /// Cargar datos del nivel (location type y description)
  Future<void> _loadLevelData() async {
    try {
      final fileName = widget.level.name;
      final jsonString = await rootBundle.loadString(
        'assets/data/$fileName.json',
      );
      final List<dynamic> jsonData = jsonDecode(jsonString);

      final match = jsonData.firstWhere(
        (entry) =>
            entry['Hint 1']?.trim() == widget.hint1.trim() &&
            entry['Hint 2']?.trim() == widget.hint2.trim() &&
            entry['Hint 3']?.trim() == widget.hint3.trim(),
        orElse: () => null,
      );

      if (match != null) {
        setState(() {
          locationType = match['Location type'];
          description = match['Description'];
        });
      } else {
        setState(() {
          errorMessage = 'No match was found for these hints.';
        });
      }
    } catch (e) {
      setState(() {
        errorMessage = 'File not yet available for this level.';
      });
    }
  }

  /// Cargar la imagen guardada desde el JSON local
  Future<void> _loadStoredImage() async {
    try {
      final fileName = widget.level.name;
      final dir = await getApplicationDocumentsDirectory();
      final localJsonPath = path.join(dir.path, '$fileName.json');

      // Si el archivo local existe, cargar la imagen desde allí
      if (File(localJsonPath).existsSync()) {
        final file = File(localJsonPath);
        final List<dynamic> jsonData = jsonDecode(await file.readAsString());

        final match = jsonData.firstWhere(
          (entry) =>
              entry['Hint 1']?.trim() == widget.hint1.trim() &&
              entry['Hint 2']?.trim() == widget.hint2.trim() &&
              entry['Hint 3']?.trim() == widget.hint3.trim(),
          orElse: () => null,
        );

        if (match != null && match['locationImage'] != null) {
          final imagePath = match['locationImage'] as String;
          if (File(imagePath).existsSync()) {
            setState(() {
              _localImageLocation = Image.file(File(imagePath), fit: BoxFit.cover);
            });
          }
        }
      }
    } catch (e) {
      debugPrint('Error al cargar imagen almacenada: $e');
    }
  }

  Future<void> _takePhoto() async {
    try {
      final XFile? photo = await _picker.pickImage(source: ImageSource.camera);
      if (photo == null) return; // Usuario canceló

      final Directory appDir = await getApplicationDocumentsDirectory();
      // Generar nombre único basado en los hints
      final String hintHash = _generateHintHash();
      final String fileName = '${widget.level.name}_${hintHash}.jpg';
      final String filePath = path.join(appDir.path, fileName);

      // Copiar la imagen
      await File(photo.path).copy(filePath);

      // Guardar la ruta en el JSON
      await _saveLocationImage(filePath);

      // Actualizar la imagen local de ESTA pantalla
      setState(() {
        _localImageLocation = Image.file(File(filePath), fit: BoxFit.cover);
      });
    } catch (e) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Error'),
          content: Text('No se pudo tomar la foto: $e'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('OK'),
            ),
          ],
        ),
      );
    }
  }

  Future<void> _saveLocationImage(String newImagePath) async {
    try {
      final fileName = widget.level.name;
      final dir = await getApplicationDocumentsDirectory();
      final localJsonPath = path.join(dir.path, '$fileName.json');

      // Verificamos si ya existe una copia local del JSON, si no la copiamos desde assets
      if (!File(localJsonPath).existsSync()) {
        final assetData = await rootBundle.loadString(
          'assets/data/$fileName.json',
        );
        await File(localJsonPath).writeAsString(assetData);
      }

      // Leemos el JSON local
      final file = File(localJsonPath);
      final List<dynamic> jsonData = jsonDecode(await file.readAsString());

      // Buscamos la entrada correspondiente
      final match = jsonData.firstWhere(
        (entry) =>
            entry['Hint 1']?.trim() == widget.hint1.trim() &&
            entry['Hint 2']?.trim() == widget.hint2.trim() &&
            entry['Hint 3']?.trim() == widget.hint3.trim(),
        orElse: () => null,
      );

      if (match != null) {
        // Si ya hay una imagen guardada para ESTA entrada específica, la eliminamos
        final oldImagePath = match['locationImage'];
        if (oldImagePath != null && oldImagePath.toString().isNotEmpty) {
          final oldFile = File(oldImagePath);
          if (await oldFile.exists()) {
            await oldFile.delete();
          }
        }

        // Actualizamos con la nueva ruta
        match['locationImage'] = newImagePath;

        // Guardamos el JSON actualizado
        await file.writeAsString(jsonEncode(jsonData));
      }
    } catch (e) {
      debugPrint('Error al guardar la imagen en JSON: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Results', style: const TextStyle(fontSize: 16)),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '${widget.level.name}',
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                /*const SizedBox(height: 10),
                Text('Hint 1: ${widget.hint1}'),
                Text('Hint 2: ${widget.hint2}'),
                Text('Hint 3: ${widget.hint3}'),*/
                const SizedBox(height: 20),

                if (errorMessage != null)
                  Text(
                    errorMessage!,
                    style: const TextStyle(color: Colors.red, fontSize: 16),
                  ),

                if (locationType != null)
                  Text(
                    'Location type: $locationType',
                    style: const TextStyle(fontSize: 13),
                  ),

                if (description != null)
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Text(
                      'Description: $description',
                      textAlign: TextAlign.center,
                    ),
                  ),

                const SizedBox(height: 20),

                // Solo mostrar la imagen local de esta pantalla
                if (_localImageLocation != null)
                  Container(
                    width: 200,
                    height: 200,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                    ),
                    child: _localImageLocation!,
                  ),
                const SizedBox(height: 20),
                ElevatedButton.icon(
                  onPressed: _takePhoto,
                  icon: const Icon(Icons.camera_alt),
                  label: const Text('Take location photo'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
