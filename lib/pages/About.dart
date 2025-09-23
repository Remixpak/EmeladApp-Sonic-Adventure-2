import 'package:flutter/material.dart';

class AboutScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('About')),
      body: Center(
        child: Text(
          'Emerald App\n'
          'Version 1.0.0\n'
          'Developed by xXREMIXPACKXx\n\n'
          '⚠️ Esta aplicacion es valida solo para las versiones de:\n'
          '- GameCube\n'
          '- PlayStation 3\n'
          '- Xbox 360\n'
          '- PC\n\n'
          '❌ No es compatible con la version de Dreamcast.',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
