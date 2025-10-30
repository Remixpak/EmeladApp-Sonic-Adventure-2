import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  double _volume = 0.5; //volumen inicial
  String _selectedSong = "main_theme"; //cancion por defecto
  bool _isDarkMode = false; //modo oscuro aunque por ahora solo funciona en esta pantalla porque no se como hacerlo global pero si me da tiempo lo cambio
  final AudioPlayer _audioPlayer = AudioPlayer();
  @override
  void dispose() {
    ///_audioPlayer.dispose();
    super.dispose();
  }
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
            //CONTROL DE VOLUMEN
            Text(
              "Volumen",
              style: TextStyle(
                fontSize: 18,
                color: _isDarkMode ? Colors.white : Colors.black,
              ),
            ),
            Slider(
              //con este widget se puede seleccionar el volumen deslizando
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

            //SELECCION DE CANCION
            Text(
              "Cancion de fondo",
              style: TextStyle(
                fontSize: 18,
                color: _isDarkMode ? Colors.white : Colors.black,
              ),
            ),
            DropdownButton<String>(
              //como un contenedor que despliega una lista de las canciones
              value: _selectedSong,
              dropdownColor: _isDarkMode ? Colors.grey[800] : Colors.white,
              items: ["main_theme", "knuckles_theme", "rouge_theme"]
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

            //MODO OSCURO
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: Icon(Icons.play_arrow),
                  onPressed: () {
                    _audioPlayer.play(
                      AssetSource('sounds/$_selectedSong.mp3'),
                      volume: _volume,
                    );
                  },
                ),
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
