import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:convert';

import 'package:url_launcher/url_launcher.dart';

class AboutScreen extends StatefulWidget {
  @override
  State<AboutScreen> createState() => _AboutScreenState();
}

class _AboutScreenState extends State<AboutScreen> {
  final String _sheetUrl =
      'https://docs.google.com/spreadsheets/d/1mZ7jBAfALq6dMAAnFUwUaGEs0Ow6Tp3TcwxB7ZGapxQ/edit?gid=8#gid=8';

  List<dynamic> questions = [];
  Map<int, dynamic> answers = {}; // guarda las respuestas del usuario
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadQuestions();
  }

  Future<void> _loadQuestions() async {
    try {
      final String jsonString = await rootBundle.loadString(
        'assets/data/questions.json',
      );
      final data = json.decode(jsonString);
      setState(() {
        questions = data['questions'];
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      print('Error cargando preguntas: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('About')),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          Center(
            child: Column(
              children: const [
                Text(
                  'Emerald App',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 6),
                Text('Versión 1.0.0', style: TextStyle(fontSize: 14)),
                SizedBox(height: 10),
              ],
            ),
          ),
          const Divider(),

          // 🔹 Información
          ExpansionTile(
            leading: const Icon(Icons.info_outline),
            title: const Text('Informacion'),
            childrenPadding: const EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: 8.0,
            ),
            children: const [
              Text(
                '⚠️ Esta aplicacion es valida solo para las versiones de:\n'
                '- GameCube\n'
                '- PlayStation 3\n'
                '- Xbox 360\n'
                '- PC\n\n'
                '⚠️ Las pistas deben ser introducidas en ingles.\n\n'
                '❌ No es compatible con la version de Dreamcast.\n\n',
              ),
            ],
          ),

          ExpansionTile(
            leading: const Icon(Icons.people_outline),
            title: const Text('Creditos'),
            childrenPadding: const EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: 8.0,
            ),
            children: const [
              Text(
                'Desarrollador: xXREMIXPACKXx\n'
                'Basado en: SA2B Hunting Locations (Google Sheet)\n',
              ),
            ],
          ),

          ExpansionTile(
            leading: const Icon(Icons.devices_other),
            title: const Text('Compatibilidad / Notas'),
            childrenPadding: const EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: 8.0,
            ),
            children: const [
              Text(
                '- Solo funciona correctamente con las versiones indicadas arriba.\n'
                '- Introducir nombres en ingles para las pistas.\n',
              ),
            ],
          ),

          ExpansionTile(
            leading: const Icon(Icons.link),
            title: const Text('Fuente / Enlace'),
            childrenPadding: const EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: 8.0,
            ),
            children: [
              SelectableText(
                _sheetUrl,
                style: const TextStyle(
                  color: Colors.blueAccent,
                  decoration: TextDecoration.underline,
                ),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  TextButton.icon(
                    onPressed: () {
                      Clipboard.setData(ClipboardData(text: _sheetUrl));
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Enlace copiado al portapapeles'),
                        ),
                      );
                    },
                    icon: const Icon(Icons.copy),
                    label: const Text('Copiar enlace'),
                  ),
                ],
              ),
            ],
          ),

          // 🔹 Valoración (interactiva)
          ExpansionTile(
            leading: const Icon(Icons.star_border),
            title: const Text('Valoracion'),
            childrenPadding: const EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: 8.0,
            ),
            children: [
              if (isLoading)
                const Center(child: CircularProgressIndicator())
              else if (questions.isEmpty)
                const Text("No se pudieron cargar las preguntas.")
              else
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: questions.map((q) {
                    final int qId = q['id'];

                    if (q['type'] == 'multiple_choice') {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            q['text'],
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          const SizedBox(height: 4),
                          ...List<Widget>.from(
                            q['options'].map<Widget>((opt) {
                              return RadioListTile(
                                title: Text(opt),
                                value: opt,
                                groupValue: answers[qId],
                                onChanged: (value) {
                                  setState(() {
                                    answers[qId] = value;
                                  });
                                },
                              );
                            }),
                          ),
                          const Divider(),
                        ],
                      );
                    } else {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            q['text'],
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          const SizedBox(height: 6),
                          TextField(
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: 'Escribe tu respuesta...',
                            ),
                            onChanged: (value) {
                              answers[qId] = value;
                            },
                          ),
                          const Divider(),
                        ],
                      );
                    }
                  }).toList(),
                ),
              const SizedBox(height: 10),
              Center(
                child: ElevatedButton.icon(
                  onPressed: () async {
                    final buffer = StringBuffer();
                    buffer.writeln('Respuestas de la valoracion:\n');
                    for (var q in questions) {
                      final id = q['id'];
                      final text = q['text'];
                      final ans = answers[id] ?? 'sin respuesta';
                      buffer.writeln('Pregunta: $text\n Respuesta: $ans\n');
                    }
                    final email = 'xxremixpakxx@gmail.com';
                    final subject = Uri.encodeComponent(
                      'Valoracion Emerald App',
                    );
                    final body = Uri.encodeComponent(buffer.toString());

                    final Uri emailUri = Uri.parse(
                      "mailto:$email?subject=$subject&body=$body",
                    );
                    print(emailUri.toString());
                    if (await canLaunchUrl(emailUri)) {
                      await launchUrl(
                        emailUri,
                        mode: LaunchMode.externalApplication,
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                            'No se puedo abrir el cliente de correo',
                          ),
                        ),
                      );
                    }
                  },
                  icon: const Icon(Icons.send),
                  label: const Text("Enviar valoracion"),
                ),
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
