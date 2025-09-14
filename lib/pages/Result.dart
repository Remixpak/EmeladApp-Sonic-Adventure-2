import 'package:flutter/material.dart';

class ResulScreen extends StatefulWidget {
  final String hint1;
  final String hint2;
  final String hint3;
  final String levelName;
  ResulScreen({
    required this.hint1,
    required this.hint2,
    required this.hint3,
    required this.levelName,
  });
  @override
  _ResultScreenState createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResulScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Result Screen', style: TextStyle(fontSize: 15)),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Result Screen', style: const TextStyle(fontSize: 24)),
            const SizedBox(height: 20),
            Text('Level Name: ${widget.levelName}'),
            Text('Hint 1: ${widget.hint1}'),
            Text('Hint 2: ${widget.hint2}'),
            Text('Hint 3: ${widget.hint3}'),
          ],
        ),
      ),
    );
  }
}
