import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  double _volume = 0.5; // volumen inicial
  String _selectedSong = "Cancion 1"; // canción por defecto
  bool _isDarkMode = false; // modo oscuro

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
        backgroundColor: _isDarkMode ? Colors.grey[900] : Colors.blue,
      ),
      body: Container(
        color: _isDarkMode ? Colors.black : Colors.white,
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // CONTROL DE VOLUMEN
            Text(
              "Volumen",
              style: TextStyle(
                fontSize: 18,
                color: _isDarkMode ? Colors.white : Colors.black,
              ),
            ),
            Slider(
              value: _volume,
              min: 0,
              max: 1,
              divisions: 10,
              label: (_volume * 100).toInt().toString(),
              onChanged: (value) {
                setState(() {
                  _volume = value;
                });
              },
            ),
            SizedBox(height: 30),

            // SELECCIÓN DE CANCIÓN
            Text(
              "Cancion de fondo",
              style: TextStyle(
                fontSize: 18,
                color: _isDarkMode ? Colors.white : Colors.black,
              ),
            ),
            DropdownButton<String>(
              value: _selectedSong,
              dropdownColor: _isDarkMode ? Colors.grey[800] : Colors.white,
              items: ["Cancion 1", "Cancion 2", "Cancion 3"]
                  .map(
                    (song) => DropdownMenuItem(
                      value: song,
                      child: Text(
                        song,
                        style: TextStyle(
                          color: _isDarkMode ? Colors.white : Colors.black,
                        ),
                      ),
                    ),
                  )
                  .toList(),
              onChanged: (value) {
                setState(() {
                  _selectedSong = value!;
                });
              },
            ),
            SizedBox(height: 30),

            // MODO OSCURO
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Modo oscuro",
                  style: TextStyle(
                    fontSize: 18,
                    color: _isDarkMode ? Colors.white : Colors.black,
                  ),
                ),
                Switch(
                  value: _isDarkMode,
                  onChanged: (value) {
                    setState(() {
                      _isDarkMode = value;
                    });
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
