import 'package:flutter/material.dart';
import '../models/levels.dart';
import '../utils/levels_storage.dart';
import 'HintScreen.dart';

class KnuckleslevelsScreen extends StatefulWidget {
  @override
  State<KnuckleslevelsScreen> createState() => _KnuckleslevelsScreenState();
}

class _KnuckleslevelsScreenState extends State<KnuckleslevelsScreen> {
  List<Level> _levels = [];

  @override
  void initState() {
    super.initState();
    _loadLevels();
  }

  Future<void> _loadLevels() async {
    final levels = await LevelsStorage.loadLevels('knuckles');
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
      await LevelsStorage.saveLevels('knuckles', _levels);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Knuckles Levels')),
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
}

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
