import 'package:emerald_app_sonic_adventure_2/pages/HintScreen.dart';
import 'package:flutter/material.dart';
import 'package:emerald_app_sonic_adventure_2/models/levels.dart';

class KnuckleslevelsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Knuckles Levels')),
      body: ListView.builder(
        itemCount: levels.length,
        itemBuilder: (context, index) {
          final level = levels[index];

          return Padding(
            padding: const EdgeInsets.all(12.0),
            child: InkWell(
              //sirve para hacer el card clickeable y no sabia que existia
              onTap: () {
                toHintScreen(context, level.name, level.image);
                print(level.name);
              },
              borderRadius: BorderRadius.circular(12),
              child: Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(12),
                        topRight: Radius.circular(12),
                      ),
                      child: SizedBox(
                        //aqui pa mostrar la imagen y que use todo el ancho del card
                        width: double.infinity,
                        height: 150,
                        child: level.image,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            //aqui mostramos los nombres
                            level.name,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 6),

                          Row(
                            //en un row las pistas y resultados para que queden abajo
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Pistas: ${level.totalHints}"),
                              Text("Resultados: ${level.totalResults}"),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
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

final List<Level> levels = [
  Level(
    name: 'Wild Canyon',
    totalHints: 297,
    totalResults: 99,
    image: Image.asset(
      'assets/images/knucklesLevels/wild_canyon_beta.png',
      fit: BoxFit.cover,
    ),
  ),
  Level(
    name: 'Pumpkin Hill',
    totalHints: 294,
    totalResults: 98,
    image: Image.asset(
      'assets/images/knucklesLevels/pumpkin_hill_beta.jpeg',
      fit: BoxFit.cover,
    ),
  ),
  Level(
    name: 'Aquatic Mine',
    totalHints: 197,
    totalResults: 99,
    image: Image.asset(
      'assets/images/knucklesLevels/aquatic_mine_beta.jpg',
      fit: BoxFit.cover,
    ),
  ),
  Level(
    name: 'Death Chamber',
    totalHints: 306,
    totalResults: 102,
    image: Image.asset(
      'assets/images/knucklesLevels/death_chamber_beta.jpg',
      fit: BoxFit.cover,
    ),
  ),
  Level(
    name: 'Meteor Herd',
    totalHints: 309,
    totalResults: 103,
    image: Image.asset(
      'assets/images/knucklesLevels/meteor_head_beta.jpg',
      fit: BoxFit.cover,
    ),
  ),
];

/*final List<Map<String, Object>> levels = [
  //los map son como los diccionarios para guardar pares clave valor para identificar cada nivel y la imagen asociada
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
];*/
