import 'package:emerald_app_sonic_adventure_2/pages/Settings.dart';
import 'package:emerald_app_sonic_adventure_2/pages/Splash.dart';
import 'package:emerald_app_sonic_adventure_2/pages/knucklesLevels.dart';
import 'package:emerald_app_sonic_adventure_2/pages/my_home_page.dart';
import 'package:emerald_app_sonic_adventure_2/pages/rougeLevels.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        fontFamily: 'sonicFonts',
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromARGB(255, 0, 8, 26),
        ),
      ),
      home: SplashScreen(),
      //home: SettingsScreen(),
      //home: const MyHomePage(title: 'Flutter Demo Home Page'),
      //home: KnuckleslevelsScreen(),
      //home: RougelevelsScreen(),
    );
  }
}
