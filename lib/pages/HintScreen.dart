import 'package:emerald_app_sonic_adventure_2/pages/Result.dart';
import 'package:flutter/material.dart';

class HintScreen extends StatefulWidget {
  final String levelName;
  final Image imageLevel;
  HintScreen({required this.levelName, required this.imageLevel});

  @override
  /*Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Hints for $levelName', style: TextStyle(fontSize: 15)),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(levelName, style: const TextStyle(fontSize: 24)),
            const SizedBox(height: 20),
            SizedBox(width: 300, height: 200, child: imageLevel),
          ],
        ),
      ),
    );
  }*/
  _HintScreenState createState() => _HintScreenState();
}

class _HintScreenState extends State<HintScreen> {
  // 👇 Controladores para capturar el texto
  final TextEditingController hint1Controller = TextEditingController();
  final TextEditingController hint2Controller = TextEditingController();
  final TextEditingController hint3Controller = TextEditingController();

  @override
  void dispose() {
    //Liberar controladores al destruir el widget
    hint1Controller.dispose();
    hint2Controller.dispose();
    hint3Controller.dispose();
    super.dispose();
  }

  void guardarHints() {
    // Guardar los textos en variables locales o usarlas como quieras
    String Hint1 = hint1Controller.text;
    String Hint2 = hint2Controller.text;
    String Hint3 = hint3Controller.text;

    print('Hint 1: $Hint1');
    print('Hint 2: $Hint2');
    print('Hint 3: $Hint3');
  }

  void toResultScreen(
    String hint1,
    String hint2,
    String hint3,
    String levelName,
  ) {
    guardarHints();
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ResulScreen(
          hint1: hint1,
          hint2: hint2,
          hint3: hint3,
          levelName: levelName,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Hints for ${widget.levelName}',
          style: const TextStyle(fontSize: 15),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            widget.imageLevel,
            const SizedBox(height: 20),

            TextField(
              controller: hint1Controller,
              decoration: const InputDecoration(
                labelText: 'Hint 1',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),

            TextField(
              controller: hint2Controller,
              decoration: const InputDecoration(
                labelText: 'Hint 2',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),

            TextField(
              controller: hint3Controller,
              decoration: const InputDecoration(
                labelText: 'Hint 3',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                toResultScreen(
                  hint1Controller.text,
                  hint2Controller.text,
                  hint3Controller.text,
                  widget.levelName,
                );
              },
              child: const Text('Result'),
            ),
          ],
        ),
      ),
    );
  }
}
