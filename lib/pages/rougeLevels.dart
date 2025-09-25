import 'package:emerald_app_sonic_adventure_2/pages/HintScreen.dart';
import 'package:flutter/material.dart';
import 'package:emerald_app_sonic_adventure_2/models/levels.dart';

class RougelevelsScreen extends StatelessWidget {
  @override
  /*
  
  ES LO MISMO QUE EN KNUCKLESLEVELS SOLO CAMBIAN LAS IMAGENES Y NOMBRES DE LOS NIVELES
  
  
  
  
  
   */
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Rouge Levels')),
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
    name: 'Dry Lagoon',
    totalHints: 303,
    totalResults: 101,
    image: Image.asset(
      'assets/images/rougeLevels/dry_lagoon_beta.png',
      fit: BoxFit.cover,
    ),
  ),
  Level(
    name: 'Egg Quarters',
    totalHints: 303,
    totalResults: 101,
    image: Image.asset(
      'assets/images/rougeLevels/egg_quarters_beta.png',
      fit: BoxFit.cover,
    ),
  ),
  Level(
    name: 'Security Hall',
    totalHints: 324,
    totalResults: 108,
    image: Image.asset(
      'assets/images/rougeLevels/security_hall_beta.png',
      fit: BoxFit.cover,
    ),
  ),
  Level(
    name: 'Mad Space',
    totalHints: 303,
    totalResults: 101,
    image: Image.asset(
      'assets/images/rougeLevels/mad_space_beta.png',
      fit: BoxFit.cover,
    ),
  ),
];

/*final List<Map<String, Object>> levels = [
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
];*/

/*INGORAR PUSE ESTO PARA COPIAR Y PEGAR LAS RUTAS
- assets/images/rougeLevels/dry_lagoon_beta.png
     - assets/images/rougeLevels/egg_quarters_beta.png
     - assets/images/rougeLevels/security_hall_beta.png
     - assets/images/rougeLevels/mad_space_beta.png



 */
