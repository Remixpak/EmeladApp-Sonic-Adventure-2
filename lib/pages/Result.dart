import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;
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

  @override
  void initState() {
    super.initState();
    _loadLevelData();
  }

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
          errorMessage = 'No se encontró una coincidencia para estas pistas.';
        });
      }
    } catch (e) {
      setState(() {
        errorMessage = 'Archivo aún no disponible';
      });
    }
  }

  Future<void> _takePhoto() async {
    try {
      final XFile? photo = await _picker.pickImage(source: ImageSource.camera);

      if (photo != null) {
        final Directory appDir = await getApplicationDocumentsDirectory();
        final String fileName = '${widget.level.name}Location.jpg';
        final String filePath = path.join(appDir.path, fileName);

        await File(photo.path).copy(filePath);

        setState(() {
          widget.level.updateLocationImage(filePath);
        });
      }
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

                if (widget.level.imageLocation != null)
                  Container(
                    width: 200,
                    height: 200,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                    ),
                    child: widget.level.imageLocation!,
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
