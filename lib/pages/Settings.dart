import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:emerald_app_sonic_adventure_2/providers/appData.dart';

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final appData = Provider.of<AppData>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Configuracion'),
        backgroundColor: Colors.blue,
      ),
      body: Container(
        color: Colors.white,
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            // Sonido activado
            _buildSwitchRow(
              label: "Sonido activado",
              value: appData.isSoundEnabled,
              onChanged: appData.setSoundEnabled,
            ),

            const SizedBox(height: 20),

            // Canción de fondo
            const Text(
              "Cancion de fondo",
              style: TextStyle(fontSize: 18, color: Colors.black),
            ),
            DropdownButton<String>(
              value: appData.selectedSong,
              items: ["main_theme", "knuckles_theme", "rouge_theme"]
                  .map(
                    (song) => DropdownMenuItem(
                      value: song,
                      child: Text(
                        song,
                        style: const TextStyle(color: Colors.black),
                      ),
                    ),
                  )
                  .toList(),
              onChanged: (value) async {
                await appData.setSelectedSong(value!);
              },
            ),

            const SizedBox(height: 30),

            // Botón de reproducir
            Center(
              child: IconButton(
                icon: const Icon(Icons.play_arrow),
                iconSize: 40,
                color: Colors.blue,
                onPressed: appData.playMusic,
              ),
            ),

            const SizedBox(height: 30),

            // Repetir una canción
            _buildSwitchRow(
              label: "Repetir solo esta cancion",
              value: appData.loopSingleSong,
              onChanged: appData.setLoopSingleSong,
            ),

            // Repetir todas las canciones
            _buildSwitchRow(
              label: "Repetir las 3 canciones",
              value: appData.loopAllSongs,
              onChanged: appData.setLoopAllSongs,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSwitchRow({
    required String label,
    required bool value,
    required Function(bool) onChanged,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Wrap(
        alignment: WrapAlignment.spaceBetween,
        crossAxisAlignment: WrapCrossAlignment.center,
        spacing: 10,
        runSpacing: 4,
        children: [
          Text(
            label,
            style: const TextStyle(fontSize: 18, color: Colors.black),
          ),
          Switch(value: value, onChanged: onChanged),
        ],
      ),
    );
  }
}
