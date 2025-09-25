import 'package:flutter/material.dart';
import 'package:emerald_app_sonic_adventure_2/pages/my_home_page.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(
        255,
        41,
        146,
        233,
      ), //no se uso el app bar aqui para simular una mejor splash screen
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/images/App_ico.png', height: 220),
            const SizedBox(height: 20),
          ],
        ),
      ),
      persistentFooterButtons: [
        SizedBox(
          width: double
              .infinity, //como es un solo boton mejor que ocupe todo el ancho creo yo 
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              foregroundColor: Colors.blue,
              padding: const EdgeInsets.symmetric(vertical: 16),
            ),
            onPressed: () {
              to_HomeScreen(context);
            },
            child: const Text('Continuar', style: TextStyle(fontSize: 18)),
          ),
        ),
      ],
    );
  }

  void to_HomeScreen(BuildContext context) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => MyHomePage(title: 'Flutter Demo Home Page'),
      ),
    );
  }
}
