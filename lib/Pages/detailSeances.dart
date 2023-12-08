// ignore_for_file: file_names, prefer_final_fields, avoid_print, prefer_const_constructors

import 'dart:async';
import 'dart:math';

import 'package:evals7/Model/chronometre.dart';
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
  bool _isVisibleChrono = false;

  bool _stateChronoCommencer = true;
  bool _stateChronoPause = false;
  bool _stateChronoTerminer = false;
  bool _stateChronoReprendre = false;

  final exoNameController = TextEditingController();
  final repetitionController = TextEditingController();
  final serieController = TextEditingController();

  late Stopwatch _stopwatch;
  late Timer _timer;
  bool _isRunning = false;

  Map<String, int> _elapsedSecondsMap = {};

  late Chronometre chrono;
  late DetailSeance detailSeance;

  @override
  void initState() {
    super.initState();
    _stopwatch = Stopwatch();
    chrono = Chronometre();
    _timer = Timer.periodic(const Duration(milliseconds: 30), _updateTime);
  }

  @override
  Widget build(BuildContext context) {
    String formattedTime = chrono.formatTime(_stopwatch.elapsedMilliseconds);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Mes Exercices'),
      ),
      body: Center(
        child: Column(
          children: [
            // if (_isVisibleChrono)
            Container(
              width: 400,
              margin: const EdgeInsets.only(bottom: 10),
              child: ElevatedButton(
                child: const Text('Commencer la séance'),
                onPressed: () {
                  setState(() {
                    _isVisibleChrono = !_isVisibleChrono;
                  });
                },
              ),
            ),
            if (_isVisibleChrono)
              Container(
                margin: const EdgeInsets.only(left: 10),
                //key: _formKey,
                child: Column(
                  children: [
                    Text(
                      formattedTime,
                      style: const TextStyle(fontSize: 48.0),
                    ),
                    Container(
                      margin: const EdgeInsets.only(bottom: 10),
                      child: Column(
                        children: [
                          if (_stateChronoCommencer)
                            Container(
                              width: 300,
                              margin: const EdgeInsets.only(bottom: 10),
                              child: ElevatedButton(
                                onPressed: () {
                                  _start();
                                  setState(() {
                                    _stateChronoCommencer =
                                        !_stateChronoCommencer;
                                    _stateChronoPause = !_stateChronoPause;
                                    _stateChronoTerminer =
                                        !_stateChronoTerminer;
                                  });
                                },
                                child: Text("Commencer la séance"),
                              ),
                            ),
                          if (_stateChronoPause)
                            Container(
                              width: 300,
                              margin: const EdgeInsets.only(bottom: 10),
                              child: ElevatedButton(
                                onPressed: () {
                                  _stop();
                                  setState(() {
                                    _stateChronoReprendre = true;
                                    _stateChronoPause = false;
                                  });
                                },
                                child: Text("Mettre en pause la séance"),
                              ),
                            ),
                          if (_stateChronoReprendre)
                            Container(
                              width: 300,
                              margin: const EdgeInsets.only(bottom: 10),
                              child: ElevatedButton(
                                onPressed: () {
                                  _start();
                                  setState(() {
                                    _stateChronoPause = true;
                                    _stateChronoReprendre = false;
                                  });
                                },
                                child: Text("Reprendre la séance"),
                              ),
                            ),
                          if (_stateChronoTerminer)
                            Container(
                              width: 300,
                              margin: const EdgeInsets.only(bottom: 10),
                              child: ElevatedButton(
                                onPressed: () {
                                  _reset();
                                  setState(() {
                                    _stateChronoCommencer =
                                        !_stateChronoCommencer;
                                    _stateChronoPause = !_stateChronoPause;
                                    _stateChronoTerminer =
                                        !_stateChronoTerminer;
                                  });

                                  String content = formattedTime;
                                  boxStatistique.add(content);
                                },
                                child: Text("Terminer la séance"),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            SizedBox(
              width: 400,
              child: ElevatedButton(
                child: const Text('Ajouter un nouveau exercice'),
                onPressed: () {
                  setState(() {
                    _isVisible = !_isVisible;
                  });
                },
              ),
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
                              exoNameController.clear();
                              repetitionController.clear();
                              serieController.clear();
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
                        detailSeance = boxDetailSeance.values
                            .where((detailSeance) =>
                                detailSeance.foreignkey == widget.seance.key)
                            .elementAt(index);

                        final exerciseKey = 'key_${detailSeance.nomExo}';
                        return ListTile(
                          leading: IconButton(
                            onPressed: () {
                              setState(() {
                                boxDetailSeance.deleteAt(index);
                                _elapsedSecondsMap.remove(exerciseKey);
                                // _resetTimer();
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
                            ],
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

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void _updateTime(Timer timer) {
    if (_isRunning) {
      setState(() {});
    }
  }

  void _start() {
    setState(() {
      _isRunning = true;
      _stopwatch.start();
    });
  }

  void _stop() {
    setState(() {
      _isRunning = false;
      _stopwatch.stop();
    });
  }

  void _reset() {
    setState(() {
      _stopwatch.reset();
      _isRunning = false;
    });
  }
}
