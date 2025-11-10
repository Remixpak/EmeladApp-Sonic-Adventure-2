import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:convert';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';

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
                Text('Version 1.0.0', style: TextStyle(fontSize: 14)),
                SizedBox(height: 10),
              ],
            ),
          ),
          const Divider(),

          // 🔹 Información
          ExpansionTile(
            leading: const Icon(Icons.info_outline),
            title: const Text('Important info'),
            childrenPadding: const EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: 8.0,
            ),
            children: const [
              Text(
                '⚠️ The application is only compatible with the following versions:\n'
                '- GameCube\n'
                '- PlayStation 3\n'
                '- Xbox 360\n'
                '- PC\n\n'
                '⚠️ Hints have to be entered in english.\n\n'
                '❌ Isn´t compatible with Dreamcast version!!!.\n\n',
              ),
            ],
          ),

          ExpansionTile(
            leading: const Icon(Icons.people_outline),
            title: const Text('Credits'),
            childrenPadding: const EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: 8.0,
            ),
            children: const [
              Text(
                'Developed by: xXREMIXPACKXx\n'
                'Based on: SA2B Hunting Locations (Google Sheet)\n',
              ),
            ],
          ),

          ExpansionTile(
            leading: const Icon(Icons.devices_other),
            title: const Text('Compatibility / Notes'),
            childrenPadding: const EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: 8.0,
            ),
            children: const [
              Text(
                '- Only works correctly with verisons mencioned.\n'
                '- Enter the hints in english.\n',
              ),
            ],
          ),

          ExpansionTile(
            leading: const Icon(Icons.link),
            title: const Text('Link'),
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
                    label: const Text('Copy'),
                  ),
                ],
              ),
            ],
          ),

          // 🔹 Valoración (interactiva)
          ExpansionTile(
            leading: const Icon(Icons.star_border),
            title: const Text('Rate this app'),
            childrenPadding: const EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: 8.0,
            ),
            children: [
              if (isLoading)
                const Center(child: CircularProgressIndicator())
              else if (questions.isEmpty)
                const Text("Cant load the questions.")
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
                              hintText: 'Write your aswer...',
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
                    buffer.writeln('Respuestas de la valoración:\n');
                    for (var q in questions) {
                      final id = q['id'];
                      final text = q['text'];
                      final ans = answers[id] ?? 'sin respuesta';
                      buffer.writeln('Pregunta: $text\nRespuesta: $ans\n');
                    }

                    final email = 'xxremixpakxx@gmail.com';
                    final subject = Uri.encodeComponent(
                      'Valoración Emerald App',
                    );
                    final body = Uri.encodeComponent(buffer.toString());

                    final Uri emailUri = Uri.parse(
                      "mailto:$email?subject=$subject&body=$body",
                    );

                    try {
                      if (await canLaunchUrl(emailUri)) {
                        await launchUrl(
                          emailUri,
                          mode: LaunchMode.externalApplication,
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                              'No se pudo abrir el cliente de correo.',
                            ),
                          ),
                        );
                      }
                    } catch (e) {
                      ScaffoldMessenger.of(
                        context,
                      ).showSnackBar(SnackBar(content: Text('Error: $e')));
                    }
                  },
                  icon: const Icon(Icons.send),
                  label: const Text("Send this rate"),
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
