import 'package:flutter/material.dart';

class KnuckleslevelsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Knuckles Levels')),
      body: ListView.builder(
        itemCount: levels.length,
        itemBuilder: (context, index) {
          final level = levels[index];

          return Padding(
            padding: const EdgeInsets.all(12.0),
            child: InkWell(
              onTap: () {
                // Acción al presionar
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
}

final List<Map<String, Object>> levels = [
  {
    'name': 'Wild Canyon',
    'image': Image.asset(
      'assets/images/knucklesLevels/wild_canyon_beta.png',
      fit: BoxFit.cover,
    ),
  },
  {
    'name': 'Pumpkin Hill',
    'image': Image.asset(
      'assets/images/knucklesLevels/pumpkin_hill_beta.jpeg',
      fit: BoxFit.cover,
    ),
  },
  {
    'name': 'Aquatic Mine',
    'image': Image.asset(
      'assets/images/knucklesLevels/aquatic_mine_beta.jpg',
      fit: BoxFit.cover,
    ),
  },
  {
    'name': 'Death Chamber',
    'image': Image.asset(
      'assets/images/knucklesLevels/death_chamber_beta.jpg',
      fit: BoxFit.cover,
    ),
  },
  {
    'name': 'Meteor Herd',
    'image': Image.asset(
      'assets/images/knucklesLevels/meteor_head_beta.jpg',
      fit: BoxFit.cover,
    ),
  },
];
