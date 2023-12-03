// ignore_for_file: library_private_types_in_public_api, prefer_const_constructors, sort_child_properties_last, duplicate_ignore, deprecated_member_use, prefer_const_literals_to_create_immutables

import 'package:evals7/Pages/detailSeances.dart';
import 'package:evals7/helper/database_helper.dart';
import 'package:flutter/material.dart';
import 'Model/seance.dart';
import 'Pages/home.dart';
import 'Pages/seances.dart';
import 'Pages/statistiques.dart';
import 'Pages/parametres.dart';

void main() async {
  await DatabaseHelper.setupDatabaseSeance();
  await DatabaseHelper.setupDatabaseDetailSeance();
  runApp(const MyApp());
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  MyHomePageState createState() => MyHomePageState();
}

class MyHomePageState extends State<MyHomePage> {
  int currentIndex = 0;
  ThemeMode themeMode = ThemeMode.light;

  final List<Widget> pages = [
    const HomeScreen(),
    const WorkoutSessionsScreen(),
    const StatisticsScreen(),
    const ParametresScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      themeMode: themeMode,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Suivi musculation'),
        ),
        body: pages[currentIndex],
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: currentIndex,
          onTap: (index) {
            setState(() {
              currentIndex = index;
            });
          },
          type: BottomNavigationBarType.fixed,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Accueil',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.fitness_center),
              label: 'Mes séances',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.bar_chart),
              label: 'Statistiques',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              label: 'Paramètres',
            ),
          ],
          selectedItemColor: Colors.blue,
          unselectedItemColor: Colors.grey,
        ),
      ),
    );
  }

  void setTheme(ThemeMode mode) {
    setState(() {
      themeMode = mode;
    });
  }
}

class MyApp extends StatelessWidget {
  static void setTheme(BuildContext context, ThemeMode themeMode) {
    final MyHomePageState state =
        context.findAncestorStateOfType<MyHomePageState>()!;
    state.setTheme(themeMode);
  }

  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      home: MyHomePage(),
    );
  }
}
