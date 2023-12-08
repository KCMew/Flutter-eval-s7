// ignore_for_file: library_private_types_in_public_api, prefer_const_constructors, sort_child_properties_last, duplicate_ignore, deprecated_member_use, prefer_const_literals_to_create_immutables

import 'package:evals7/helper/boxes.dart';
import 'package:evals7/helper/database_helper.dart';
import 'package:flutter/material.dart';
import 'Pages/home.dart';
import 'Pages/seances.dart';
import 'Pages/statistiques.dart';
import 'Pages/parametres.dart';

void main() async {
  await DatabaseHelper.setupDatabaseSeance();
  await DatabaseHelper.setupDatabaseDetailSeance();
  await DatabaseHelper.setupDatabaseParametre();
  await DatabaseHelper.setupDatabaseStatistique();
  runApp(const MyApp());
}

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  MainPageState createState() => MainPageState();
}

class MainPageState extends State<MainPage> {
  int currentIndex = 0;
  late ThemeMode themeMode;
  bool darkMode = false;

  final List<Widget> pages = [
    const HomeScreen(),
    const WorkoutSessionsScreen(),
    const StatisticsScreen(),
    const ParametresScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
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
          selectedItemColor: Colors.purple,
          unselectedItemColor: Colors.grey,
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    darkMode = boxParametre.get('darkmode') ?? false;
    if (darkMode == true) {
      themeMode = ThemeMode.light;
    } else {
      themeMode = ThemeMode.dark;
    }
  }

  void setTheme(ThemeMode mode) {
    setState(() {
      themeMode = mode;
    });
  }
}

class MyApp extends StatelessWidget {
  static void setTheme(BuildContext context, ThemeMode themeMode) {
    final MainPageState state =
        context.findAncestorStateOfType<MainPageState>()!;
    state.setTheme(themeMode);
  }

  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      home: MainPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
