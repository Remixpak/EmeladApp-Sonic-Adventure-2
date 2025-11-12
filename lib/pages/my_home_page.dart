import 'package:emerald_app_sonic_adventure_2/pages/knucklesLevels.dart';
import 'package:emerald_app_sonic_adventure_2/pages/rougeLevels.dart';
import 'package:emerald_app_sonic_adventure_2/pages/Settings.dart';
import 'package:emerald_app_sonic_adventure_2/pages/About.dart';
import 'package:emerald_app_sonic_adventure_2/providers/appData.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with WidgetsBindingObserver {
  bool _musicStarted = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    // Iniciamos la música después del primer frame
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _initializeMusic();
    });
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  Future<void> _initializeMusic() async {
    if (!_musicStarted && mounted) {
      final appData = Provider.of<AppData>(context, listen: false);
      
      // Esperar a que los datos carguen
      while (!appData.isDataLoaded) {
        await Future.delayed(Duration(milliseconds: 100));
      }
      
      // Reproducir música si está habilitada
      if (appData.isSoundEnabled) {
        appData.playMusic();
      }
      _musicStarted = true;
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    final appData = Provider.of<AppData>(context, listen: false);

    if (state == AppLifecycleState.paused ||
        state == AppLifecycleState.detached) {
      // Pausa o detiene la música cuando sales de la app o bloqueas pantalla
      appData.stopMusic();
    } else if (state == AppLifecycleState.resumed && appData.isSoundEnabled) {
      // Vuelve a reproducir si regresas y el sonido está habilitado
      appData.playMusic();
    }
  }

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
                    ..color = const Color.fromARGB(255, 255, 175, 2),
                ),
              ),
              const Text(
                'Emerald App ',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 0, 94, 170),
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
            },
          ),
        ],
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/SA2bg3.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Padding(
                padding: EdgeInsets.only(bottom: 40.0),
                child: Text(
                  'Select your character',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
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
                          iconSize: 80,
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
