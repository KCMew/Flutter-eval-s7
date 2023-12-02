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
            const Text('Mode sombre'),
            Switch(
              value: isDarkMode,
              onChanged: (value) {
                setState(() {
                  isDarkMode = value;
                });
                ThemeMode themeMode =
                    isDarkMode ? ThemeMode.dark : ThemeMode.light;
                MyApp.setTheme(context, themeMode);
              },
            ),
          ],
        ),
      ),
    );
  }
}
