import 'package:emerald_app_sonic_adventure_2/pages/Result.dart';
import 'package:flutter/material.dart';
import '../models/levels.dart';

class HintScreen extends StatefulWidget {
  final Level level;

  HintScreen({required this.level});

  @override
  _HintScreenState createState() => _HintScreenState();
}

class _HintScreenState extends State<HintScreen> {
  final TextEditingController hint1Controller = TextEditingController();
  final TextEditingController hint2Controller = TextEditingController();
  final TextEditingController hint3Controller = TextEditingController();

  @override
  void dispose() {
    //en teoria por lo que entendi esto flutter lo llama automaticamente cuando se destruye la pantalla
    hint1Controller.dispose();
    hint2Controller.dispose();
    hint3Controller.dispose();
    super.dispose();
  }

  void guardarHints() {
    print('Hint 1: ${hint1Controller.text}');
    print('Hint 2: ${hint2Controller.text}');
    print('Hint 3: ${hint3Controller.text}');
  }

  void toResultScreen(String hint1, String hint2, String hint3, Level level) {
    guardarHints();
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            ResulScreen(hint1: hint1, hint2: hint2, hint3: hint3, level: level),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Hints for ${widget.level.name}',
          style: const TextStyle(fontSize: 15),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          //esto soluciona lo del overflow cuando se abre el teclado ya que por defecto todo lo de la pantalla y el teclado no caben
          children: [
            SizedBox(
              width: 300,
              height: 200,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: FittedBox(fit: BoxFit.cover, child: widget.level.image),
              ),
            ),
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
                  widget.level,
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
