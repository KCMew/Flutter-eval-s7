// ignore_for_file: library_private_types_in_public_api, prefer_const_constructors, sort_child_properties_last, duplicate_ignore, deprecated_member_use, prefer_const_literals_to_create_immutables

import 'package:evals7/Pages/addSeances.dart';
import 'package:evals7/helper/database_helper.dart';
import 'package:flutter/material.dart';
import 'Pages/seances.dart';
import 'Pages/statistiques.dart';
import 'Pages/parametres.dart';

void main() async {
  await DatabaseHelper.setupDatabase();
  runApp(const MyApp());
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
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Center(
            child: Text(
              'Exercice suivant',
              style: Theme.of(context)
                  .textTheme
                  .headline6!
                  .copyWith(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          Card(
            margin: const EdgeInsets.only(top: 16.0),
            elevation: 0,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: ColorFiltered(
                    colorFilter: ColorFilter.mode(
                      Colors.blue.withOpacity(0.9),
                      BlendMode.overlay,
                    ),
                    child: Image.network(
                      'https://www.expo2020dubai.com/-/media/expo2020/2021/experiences/sport-and-fitness/fitness-hero-1920x1080.png',
                      height: 150,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      SizedBox(height: 3),
                      Text(
                        'Course à pieds\n30km - Durée estimée : 1h15',
                        style: Theme.of(context).textTheme.subtitle1,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 27),
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Activités récentes',
                style: Theme.of(context)
                    .textTheme
                    .headline6!
                    .copyWith(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListTile(
                  leading: Image.network(
                    'https://www.expo2020dubai.com/-/media/expo2020/2021/experiences/sport-and-fitness/fitness-hero-1920x1080.png',
                    height: 80,
                    fit: BoxFit.cover,
                  ),
                  title: Text(
                    'Titre de l\'activité',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: LinearProgressIndicator(
                  value: 0.50,
                  backgroundColor: Colors.grey,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Progression : 10/20',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    InkWell(
                      onTap: () {
                        // Navigator.push();
                      },
                      child: Row(
                        children: [
                          Text(
                            'Continuer',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Icon(Icons.arrow_forward),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListTile(
                  leading: Image.network(
                    'https://www.expo2020dubai.com/-/media/expo2020/2021/experiences/sport-and-fitness/fitness-hero-1920x1080.png',
                    height: 80,
                    fit: BoxFit.cover,
                  ),
                  title: Text(
                    'Titre de l\'activité',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: LinearProgressIndicator(
                  value: 0.50,
                  backgroundColor: Colors.grey,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Progression : 10/20',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    InkWell(
                      onTap: () {
                        // Navigator.push();
                      },
                      child: Row(
                        children: [
                          Text(
                            'Continuer',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Icon(Icons.arrow_forward),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
