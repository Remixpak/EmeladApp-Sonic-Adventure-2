import 'package:emerald_app_sonic_adventure_2/pages/HintScreen.dart';
import 'package:flutter/material.dart';
import 'package:emerald_app_sonic_adventure_2/models/levels.dart';
import '../utils/levels_storage.dart';

class RougelevelsScreen extends StatefulWidget {
  @override
  /*
  
  ES LO MISMO QUE EN KNUCKLESLEVELS SOLO CAMBIAN LAS IMAGENES Y NOMBRES DE LOS NIVELES
  
  
  
  
  
   */
  State<RougelevelsScreen> createState() => _RougelevelsScreenState();

  void toHintScreen(BuildContext context, Level level) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => HintScreen(level: level)),
    );
  }
}

class _RougelevelsScreenState extends State<RougelevelsScreen> {
  List<Level> _levels = [];

  @override
  void initState() {
    super.initState();
    _loadLevels();
  }

  Future<void> _loadLevels() async {
    final levels = await LevelsStorage.loadLevels('rouge');
    setState(() {
      _levels = levels;
    });
  }

  void _goToHintScreen(Level level) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => HintScreen(level: level)),
    ).then((_) async {
      // Cuando regrese de ResultScreen, guardamos los cambios
      await LevelsStorage.saveLevels('rouge', _levels);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Rouge Levels')),
      body: _levels.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: _levels.length,
              itemBuilder: (context, index) {
                final level = _levels[index];
                return Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: InkWell(
                    onTap: () => _goToHintScreen(level),
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
                                  level.name,
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 6),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("Total hints: ${level.totalHints}"),
                                    Text(
                                      "Total results: ${level.totalResults}",
                                    ),
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
}

/*final List<Level> levels = [
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
];*/

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
