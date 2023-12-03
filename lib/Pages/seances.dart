// séances.dart
// ignore_for_file: file_names

import 'package:evals7/Model/seance.dart';
import 'package:evals7/helper/boxes.dart';
import 'package:evals7/helper/database_helper.dart';
import 'package:flutter/material.dart';
import 'detailSeances.dart';
import '../main.dart';

class WorkoutSessionsScreen extends StatefulWidget {
  const WorkoutSessionsScreen({Key? key}) : super(key: key);

  @override
  SeanceState createState() => SeanceState();
}

class SeanceState extends State<WorkoutSessionsScreen> {
  bool isDarkMode = false;
  bool _isVisible = false;

  final _formKey = GlobalKey<FormState>();

  final seanceNameController = TextEditingController();
  String selectedJourType = 'Lundi';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mes Séances'),
      ),
      body: Center(
        child: Column(
          children: [
            // Bouton pour afficher la zone
            ElevatedButton(
              child: const Text(
                'Ajouter une nouvelle séance',
              ),
              onPressed: () {
                setState(() {
                  _isVisible = !_isVisible;
                });
              },
            ),

            // Zone cachée par défaut
            if (_isVisible)
              Container(
                margin: const EdgeInsets.all(20),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(bottom: 10),
                        child: TextFormField(
                          decoration: const InputDecoration(
                            labelText: ' Nom de la séance',
                            hintText: 'Entrez le nom de la séance',
                            border: OutlineInputBorder(),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Veuillez choisir un nom de séance";
                            }
                            return null;
                          },
                          controller: seanceNameController,
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(bottom: 10),
                        child: DropdownButtonFormField(
                            items: const [
                              DropdownMenuItem(
                                value: 'Lundi',
                                child: Text('Lundi'),
                              ),
                              DropdownMenuItem(
                                value: 'Mardi',
                                child: Text('Mardi'),
                              ),
                              DropdownMenuItem(
                                value: 'Mercredi',
                                child: Text('Mercredi'),
                              ),
                              DropdownMenuItem(
                                value: 'Jeudi',
                                child: Text('Jeudi'),
                              ),
                              DropdownMenuItem(
                                value: 'Vendredi',
                                child: Text('Vendredi'),
                              ),
                              DropdownMenuItem(
                                value: 'Samedi',
                                child: Text('Samedi'),
                              ),
                              DropdownMenuItem(
                                value: 'Dimanche',
                                child: Text('Dimanche'),
                              ),
                            ],
                            decoration: const InputDecoration(
                              labelText: ' Jour de la séance',
                              hintText: 'Entrez le jour de la séance',
                              border: OutlineInputBorder(),
                            ),
                            value: selectedJourType,
                            onChanged: (value) {
                              setState(() {
                                selectedJourType = value!;
                              });
                            }),
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              final seanceName = seanceNameController.text;
                              /* await DatabaseHelper.addSeance(
                                  seanceName, selectedJourType);
                              print(seanceName);
                              print(selectedJourType); */
                              setState(() {
                                boxSeance.put(
                                  'key_$seanceNameController',
                                  Seance(
                                      nomSeance: seanceName,
                                      jourSeance: selectedJourType),
                                );
                              });
                            }
                          },
                          child: const Text('Ajouter'),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: ListView.builder(
                      itemCount: boxSeance.length,
                      itemBuilder: (contexte, index) {
                        Seance seance = boxSeance.getAt(index);
                        return ListTile(
                          leading: IconButton(
                            onPressed: () {
                              setState(() {
                                boxSeance.deleteAt(index);
                              });
                            },
                            icon: const Icon(Icons.delete),
                          ),
                          title: Text(seance.nomSeance),
                          //subtitle: Text('Jour: ${seance.jourSeance}'),
                          // subtitle: const Text('Seance'),
                          trailing: Text('Jour: ${seance.jourSeance}'),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => DetailSeanceScreen(
                                    seance: seance = boxSeance.getAt(index)),
                              ),
                            );
                          },
                        );
                      },
                    ),
                  ),
                ),
              ),
            ),
            TextButton.icon(
              onPressed: () {
                setState(() {
                  boxSeance.clear();
                });
              },
              icon: const Icon(Icons.delete_outline),
              label: const Text('Tout supprimer'),
            ),
            const SizedBox(height: 10.0),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    seanceNameController.dispose();
  }
}
