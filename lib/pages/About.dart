import 'package:flutter/material.dart';

class AboutScreen extends StatelessWidget {
  final String _sheetUrl =
      'https://docs.google.com/spreadsheets/d/1mZ7jBAfALq6dMAAnFUwUaGEs0Ow6Tp3TcwxB7ZGapxQ/edit?gid=8#gid=8';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('About')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Emerald App\n'
              'Version 1.0.0\n'
              'Developed by xXREMIXPACKXx\n\n'
              '⚠️ Esta aplicación es válida solo para las versiones de:\n'
              '- GameCube\n'
              '- PlayStation 3\n'
              '- Xbox 360\n'
              '- PC\n\n'
              '⚠️ Las pistas deben ser introducidas en ingles.\n\n'
              '❌ No es compatible con la versión de Dreamcast.\n\n',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 15),
            ),
            const Text(
              'Basado en el archivo SA2B Hunting Locations en Google Sheet',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 8),
            Text(
              _sheetUrl,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 14, color: Colors.black87),
            ),
          ],
        ),
      ),
    );
  }
}
