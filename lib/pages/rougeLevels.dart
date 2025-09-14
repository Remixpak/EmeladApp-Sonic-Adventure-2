import 'package:emerald_app_sonic_adventure_2/pages/HintScreen.dart';
import 'package:flutter/material.dart';

class RougelevelsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Rouge Levels')),
      body: ListView.builder(
        itemCount: levels.length,
        itemBuilder: (context, index) {
          final level = levels[index];

          return Padding(
            padding: const EdgeInsets.all(12.0),
            child: InkWell(
              onTap: () {
                toHintScreen(
                  context,
                  level['name'] as String,
                  level['image'] as Image,
                );
                print(level['name']);
              },
              borderRadius: BorderRadius.circular(12),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 200,
                    height: 150,
                    child: level['image'] as Widget,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    level['name'] as String,
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  void toHintScreen(BuildContext context, String levelName, Image imageLevel) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            HintScreen(levelName: levelName, imageLevel: imageLevel),
      ),
    );
  }
}

final List<Map<String, Object>> levels = [
  {
    'name': 'Dry Lagoon',
    'image': Image.asset(
      'assets/images/rougeLevels/dry_lagoon_beta.png',
      fit: BoxFit.cover,
    ),
  },
  {
    'name': 'Egg Quarters',
    'image': Image.asset(
      'assets/images/rougeLevels/egg_quarters_beta.png',
      fit: BoxFit.cover,
    ),
  },
  {
    'name': 'Security Hall',
    'image': Image.asset(
      'assets/images/rougeLevels/security_hall_beta.png',
      fit: BoxFit.cover,
    ),
  },
  {
    'name': 'Mad Space',
    'image': Image.asset(
      'assets/images/rougeLevels/mad_space_beta.png',
      fit: BoxFit.cover,
    ),
  },
];

/*
- assets/images/rougeLevels/dry_lagoon_beta.png
     - assets/images/rougeLevels/egg_quarters_beta.png
     - assets/images/rougeLevels/security_hall_beta.png
     - assets/images/rougeLevels/mad_space_beta.png



 */
