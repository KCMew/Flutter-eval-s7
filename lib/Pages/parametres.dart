import 'package:evals7/helper/boxes.dart';
import 'package:flutter/material.dart';
import '../main.dart';

class ParametresScreen extends StatefulWidget {
  const ParametresScreen({Key? key}) : super(key: key);

  @override
  SettingsState createState() => SettingsState();
}

class SettingsState extends State<ParametresScreen> {
  bool darkMode = false;

  @override
  void initState() {
    super.initState();
    darkMode = boxParametre.get('darkmode') ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Paramètres'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Mode clair'),
            Switch(
              value: darkMode,
              onChanged: (value) {
                setState(() {
                  darkMode = value;
                  boxParametre.put('darkmode', darkMode);
                });
                ThemeMode themeMode =
                    darkMode ? ThemeMode.light : ThemeMode.dark;
                MyApp.setTheme(context, themeMode);
              },
            ),
          ],
        ),
      ),
    );
  }
}
