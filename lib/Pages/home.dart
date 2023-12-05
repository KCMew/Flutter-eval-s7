// ignore_for_file: file_names, prefer_const_constructors, deprecated_member_use, prefer_const_literals_to_create_immutables

import 'package:evals7/Model/seance.dart';
import 'package:evals7/helper/boxes.dart';
import 'package:flutter/material.dart';
import 'detailSeances.dart';
import 'dart:core';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  SeanceState createState() => SeanceState();
}

class SeanceState extends State<HomeScreen> {
  bool isDarkMode = false;
  final seanceNameController = TextEditingController();
  String selectedJourType = 'Lundi';

  @override
  Widget build(BuildContext context) {
    final currentDay = DateTime.now().weekday;

    final sessionsForCurrentDay = boxSeance.values.where((seance) {
      return seance.jourSeance == getLocalDay(currentDay);
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Accueil'),
      ),
      body: Center(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                'Séance du ${getLocalDay(currentDay)}',
                style: Theme.of(context).textTheme.headline6,
              ),
            ),
            Image.network(
              'https://payfacile-prod.s3-eu-west-1.amazonaws.com/productImages/7kWvAGgqmr3a34QQH/1646837939151_shutterstock-721723381-2.jpg',
              width: double.infinity,
              height: 200,
              fit: BoxFit.cover,
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: ListView.builder(
                  padding: EdgeInsets.symmetric(horizontal: 10.0),
                  itemCount: sessionsForCurrentDay.length,
                  itemBuilder: (contexte, index) {
                    Seance seance = sessionsForCurrentDay[index];
                    return Card(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ListTile(
                          leading: Image.network(
                            'https://payfacile-prod.s3-eu-west-1.amazonaws.com/productImages/7kWvAGgqmr3a34QQH/1646837939151_shutterstock-721723381-2.jpg',
                            width: 80,
                            height: 80,
                            fit: BoxFit.cover,
                          ),
                          title: Text(seance.nomSeance),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                'Voir plus',
                                style: TextStyle(fontSize: 16),
                              ),
                              Icon(Icons.arrow_forward),
                            ],
                          ),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => DetailSeanceScreen(
                                  seance: seance,
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    );
                  },
                ),
              ),
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

  String getLocalDay(int day) {
    switch (day) {
      case 1:
        return 'Lundi';
      case 2:
        return 'Mardi';
      case 3:
        return 'Mercredi';
      case 4:
        return 'Jeudi';
      case 5:
        return 'Vendredi';
      case 6:
        return 'Samedi';
      case 7:
        return 'Dimanche';
      default:
        return '';
    }
  }
}
