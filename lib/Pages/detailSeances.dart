// ignore_for_file: file_names, prefer_final_fields, avoid_print, prefer_const_constructors

import 'dart:async';

import 'package:evals7/Model/detail_seance.dart';
import 'package:evals7/Model/seance.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../helper/boxes.dart';

class DetailSeanceScreen extends StatefulWidget {
  final Seance seance;
  const DetailSeanceScreen({Key? key, required this.seance}) : super(key: key);

  @override
  DetailSeanceState createState() => DetailSeanceState();
}

class DetailSeanceState extends State<DetailSeanceScreen> {
  final _formKey = GlobalKey<FormState>();
  bool _isVisible = false;

  final exoNameController = TextEditingController();
  final repetitionController = TextEditingController();
  final serieController = TextEditingController();

  late Timer _timer;
  Map<String, int> _elapsedSecondsMap = {};
  String? _activeExerciseKey;

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mes Exercices'),
      ),
      body: Center(
        child: Column(
          children: [
            ElevatedButton(
              child: const Text('Ajouter un nouveau exercice'),
              onPressed: () {
                setState(() {
                  _isVisible = !_isVisible;
                });
              },
            ),
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
                            labelText: " Nom de l'exercice",
                            hintText: " Entrez le nom de l'exercice",
                            border: OutlineInputBorder(),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Veuillez choisir un nom d'exercice";
                            }
                            return null;
                          },
                          controller: exoNameController,
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(bottom: 10),
                        child: TextFormField(
                          decoration: const InputDecoration(
                            labelText: " Nombre de série",
                            hintText: " Entrez le nombre de série",
                            border: OutlineInputBorder(),
                          ),
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                          ],
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Veuillez rentrez le nombre de série";
                            }
                            return null;
                          },
                          controller: serieController,
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(bottom: 10),
                        child: TextFormField(
                          decoration: const InputDecoration(
                            labelText: " Nombre de répétition",
                            hintText: " Entrez le nombre de répétition",
                            border: OutlineInputBorder(),
                          ),
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                          ],
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Veuillez rentrez le nombre de répétition";
                            }
                            return null;
                          },
                          controller: repetitionController,
                        ),
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              final exoName = exoNameController.text;
                              final serieNb =
                                  int.tryParse(serieController.text);
                              final repetitionNb =
                                  int.tryParse(repetitionController.text);
                              final seanceName = widget.seance.nomSeance;
                              final foreignKey = widget.seance.key;
                              final exerciseKey = 'key_$exoNameController';
                              setState(() {
                                boxDetailSeance.put(
                                  exerciseKey,
                                  DetailSeance(
                                    nomSeance: seanceName,
                                    nomExo: exoName,
                                    nbSerie: serieNb,
                                    nbRepetition: repetitionNb,
                                    foreignkey: foreignKey,
                                  ),
                                );
                                _elapsedSecondsMap[exerciseKey] = 0;
                              });
                              print('add : $foreignKey');
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
                      itemCount: boxDetailSeance.values
                          .where((detailSeance) =>
                              detailSeance.foreignkey == widget.seance.key)
                          .length,
                      itemBuilder: (contexte, index) {
                        DetailSeance detailSeance = boxDetailSeance.values
                            .where((detailSeance) =>
                                detailSeance.foreignkey == widget.seance.key)
                            .elementAt(index);

                        final exerciseKey = 'key_${detailSeance.nomExo}';
                        final isTimerActive = _activeExerciseKey == exerciseKey;
                        print("--------------------------------");
                        print("test key depuis detail : ${widget.seance.key}");
                        print("--------------------------------");

                        return ListTile(
                          leading: IconButton(
                            onPressed: () {
                              setState(() {
                                boxDetailSeance.deleteAt(index);
                                _elapsedSecondsMap.remove(exerciseKey);
                                _resetTimer();
                              });
                            },
                            icon: const Icon(Icons.delete),
                          ),
                          title: Text(detailSeance.nomExo),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Nombre de série : ${detailSeance.nbSerie}'),
                              Text(
                                  'Nombre de répétition : ${detailSeance.nbRepetition}'),
                              Text(
                                'Temps écoulé : ${_formatElapsedTime(_elapsedSecondsMap[exerciseKey] ?? 0)}',
                              ),
                            ],
                          ),
                          trailing: ElevatedButton(
                            onPressed: () {
                              setState(() {
                                if (isTimerActive) {
                                  _resetTimer();
                                } else {
                                  _startTimer(exerciseKey);
                                }
                              });
                            },
                            child: Text(isTimerActive ? 'Arrêter' : 'Démarrer'),
                          ),
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
                  boxDetailSeance.clear();
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

  void _startTimer(String exerciseKey) {
    _activeExerciseKey = exerciseKey;
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        _elapsedSecondsMap[exerciseKey] =
            (_elapsedSecondsMap[exerciseKey] ?? 0) + 1;
      });
    });
  }

  void _resetTimer() {
    _timer.cancel();
    _activeExerciseKey = null;
  }

  String _formatElapsedTime(int seconds) {
    final minutes = seconds ~/ 60;
    final remainingSeconds = seconds % 60;
    return '$minutes:${remainingSeconds.toString().padLeft(2, '0')}';
  }
}
