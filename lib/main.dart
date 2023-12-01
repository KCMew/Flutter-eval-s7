  // ignore_for_file: library_private_types_in_public_api, prefer_const_constructors, sort_child_properties_last, duplicate_ignore

 // ignore_for_file: library_private_types_in_public_api, prefer_const_constructors, sort_child_properties_last

import 'package:flutter/material.dart';
import 'seances.dart';
import 'statistiques.dart';
import 'parametres.dart';

void main() => runApp(const MyApp());

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
    ParametresScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      themeMode: themeMode,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('App Muscu'),
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
              icon: Icon(Icons.home, color: Colors.grey),
              label: 'Accueil',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.fitness_center, color: Colors.grey),
              label: 'Mes séances',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.bar_chart, color: Colors.grey),
              label: 'Statistiques',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings, color: Colors.grey),
              label: 'Paramètres',
            ),
          ],
          selectedItemColor: Colors.grey,
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

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Accueil Screen'),
    );
  }
}
