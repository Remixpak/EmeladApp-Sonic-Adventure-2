import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AboutScreen extends StatelessWidget {
  final String _sheetUrl =
      'https://docs.google.com/spreadsheets/d/1mZ7jBAfALq6dMAAnFUwUaGEs0Ow6Tp3TcwxB7ZGapxQ/edit?gid=8#gid=8';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('About')),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          // Encabezado
          Center(
            child: Column(
              children: const [
                Text(
                  'Emerald App',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 6),
                Text('Version 1.0.0', style: TextStyle(fontSize: 14)),
                SizedBox(height: 10),
              ],
            ),
          ),
          const Divider(),

          // Apartados por secciones
          ExpansionTile(
            leading: const Icon(Icons.info_outline),
            title: const Text('Informacion'),
            childrenPadding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            children: const [
              Text(
                '⚠️ Esta aplicacion es valida solo para las versiones de:\n'
                '- GameCube\n'
                '- PlayStation 3\n'
                '- Xbox 360\n'
                '- PC\n\n'
                '⚠️ Las pistas deben ser introducidas en ingles.\n\n'
                '❌ No es compatible con la version de Dreamcast.\n\n',
                textAlign: TextAlign.left,
              ),
            ],
          ),

          ExpansionTile(
            leading: const Icon(Icons.people_outline),
            title: const Text('Creditos'),
            childrenPadding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            children: const [
              Text(
                'Desarrollador: xXREMIXPACKXx\n'
                'Basado en: SA2B Hunting Locations (Google Sheet)\n'
                
              ),
            ],
          ),

          ExpansionTile(
            leading: const Icon(Icons.devices_other),
            title: const Text('Compatibilidad / Notas'),
            childrenPadding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            children: const [
              Text(
                '- Solo funciona correctamente con las versiones indicadas arriba.\n'
                '- Introducir nombres en ingles para las pistas.\n'
                
              ),
            ],
          ),

          ExpansionTile(
            leading: const Icon(Icons.link),
            title: const Text('Fuente / Enlace'),
            childrenPadding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            children: [
              SelectableText(
                _sheetUrl,
                style: const TextStyle(color: Colors.blueAccent, decoration: TextDecoration.underline),
                textAlign: TextAlign.left,
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  TextButton.icon(
                    onPressed: () {
                      Clipboard.setData(ClipboardData(text: _sheetUrl));
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Enlace copiado al portapapeles')),
                      );
                    },
                    icon: const Icon(Icons.copy),
                    label: const Text('Copiar enlace'),
                  ),
                  const SizedBox(width: 8),
                  // Si quieres abrir el enlace en el navegador, puedo añadir url_launcher y el botón aquí.
                ],
              ),
            ],
          ),
          ExpansionTile(
            leading: const Icon(Icons.star_border),
            title: const Text('Valoracion'),
            childrenPadding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            children: const [
              Text(
                'aqui se implementaria la valoracion de la app\n',
                textAlign: TextAlign.left,
              ),
            ],
          ),
          const SizedBox(height: 16),
          Center(
            child: Text(
              '© 2025 Emerald App. All rights reserved.',
              style: TextStyle(fontSize: 12, color: Colors.grey[600]),
            ),
          ),
        ],
      ),
    );
  }
}
