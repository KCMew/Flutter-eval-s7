import 'package:flutter/material.dart';
import '../main.dart';

class ParametresScreen extends StatefulWidget {
  const ParametresScreen({Key? key}) : super(key: key);

  @override
  SettingsState createState() => SettingsState();
}

class SettingsState extends State<ParametresScreen> {
  bool isDarkMode = false;

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
            ElevatedButton(
              onPressed: () {
                setThemeMode(ThemeMode.light);
              },
              child: const Text('Thème clair'),
            ),
           const SizedBox(height: 10.0),
            ElevatedButton(
              onPressed: () {
                setThemeMode(ThemeMode.dark);
              },
              child: const Text('Thème sombre'),
            ),
          ],
        ),
      ),
    );
  }

  void setThemeMode(ThemeMode themeMode) {
    setState(() {
      isDarkMode = themeMode == ThemeMode.dark;
    });
    MyApp.setTheme(context, themeMode);
  }
}
