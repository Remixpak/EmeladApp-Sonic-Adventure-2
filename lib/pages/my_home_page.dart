import 'package:emerald_app_sonic_adventure_2/pages/knucklesLevels.dart';
import 'package:emerald_app_sonic_adventure_2/pages/rougeLevels.dart';
import 'package:emerald_app_sonic_adventure_2/pages/Settings.dart';
import 'package:emerald_app_sonic_adventure_2/pages/About.dart';
import 'package:flutter/material.dart';

//import 'package:soundpool/soundpool.dart';
//import 'package:flutter/services.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Center(
          child: Stack(
            children: [
              Text(
                'Emerald App ',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  foreground: Paint()
                    ..style = PaintingStyle.stroke
                    ..strokeWidth = 10
                    ..color = const Color.fromARGB(
                      255,
                      255,
                      175,
                      2,
                    ), //contorno de las letras
                ),
              ),
              Text(
                'Emerald App ',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(
                    255,
                    0,
                    94,
                    170,
                  ), //relleno de las letras
                ),
              ),
            ],
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              to_SettingsScreen();
              print("Botón Settings presionado");
            },
          ),
          IconButton(
            icon: const Icon(Icons.info_outline),
            onPressed: () {
              to_AboutScreen();
              print("Botón Info presionado");
              /*showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text("Información"),
                  content: const Text(
                    "Emerald App - Sonic Adventure 2\nVersión 1.0",
                  ),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text("Cerrar"),
                    ),
                  ],
                ),
              );*/
            },
          ),
        ],
      ),

      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/SA2bg3.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 40.0),
                child: Text(
                  'Select your character',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: const Color.fromARGB(255, 255, 255, 255),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Card(
                    color: Colors.red,
                    child: SizedBox(
                      width: 150,
                      height: 200,
                      child: Center(
                        child: IconButton(
                          iconSize: 80, //Tamaño del área clickeable
                          icon: Image.asset(
                            'assets/images/Knck.png',
                            width: 80,
                            height: 80,
                            fit: BoxFit.contain,
                          ),
                          onPressed: () {
                            print("Botón Knuckles presionado");
                            to_KnucklesLevels();
                          },
                        ),
                      ),
                    ),
                  ),
                  Card(
                    color: Colors.purple,
                    child: SizedBox(
                      width: 150,
                      height: 200,
                      child: Center(
                        child: IconButton(
                          iconSize: 80,
                          icon: Image.asset(
                            'assets/images/Rouge.png',
                            width: 80,
                            height: 80,
                            fit: BoxFit.contain,
                          ),
                          onPressed: () {
                            print("Botón Rouge presionado");
                            to_RougeLevels();
                          },
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void to_KnucklesLevels() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => KnuckleslevelsScreen()),
    );
  }

  void to_RougeLevels() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => RougelevelsScreen()),
    );
  }

  void to_SettingsScreen() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SettingsScreen()),
    );
  }

  void to_AboutScreen() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AboutScreen()),
    );
  }
}
