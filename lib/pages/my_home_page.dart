import 'package:emerald_app_sonic_adventure_2/pages/knucklesLevels.dart';
import 'package:emerald_app_sonic_adventure_2/pages/rougeLevels.dart';
import 'package:flutter/material.dart';

//import 'package:soundpool/soundpool.dart';
//import 'package:flutter/services.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

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
                    ), // contorno
                ),
              ),
              Text(
                'Emerald App ',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 0, 94, 170), // color de relleno
                ),
              ),
            ],
          ),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/SA2bg3.png'), // tu imagen de fondo
            fit: BoxFit.cover, // cubre toda la pantalla
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 40.0), //subir el texto
                child: Text(
                  'Select your character',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: const Color.fromARGB(
                      255,
                      255,
                      255,
                      255,
                    ), // recomendable si tu fondo es oscuro
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
                          iconSize: 80, // Tamaño del área clickeable
                          icon: Image.asset(
                            'assets/images/Knck.png',
                            width: 80,
                            height: 80,
                            fit: BoxFit.contain,
                          ),
                          onPressed: () {
                            // Acción cuando se presiona
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
}
