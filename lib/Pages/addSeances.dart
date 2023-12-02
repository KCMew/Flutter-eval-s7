// statistiques.dart
import 'package:flutter/material.dart';

class AddSeanceScreen extends StatefulWidget {
  const AddSeanceScreen({Key? key}) : super(key: key);

  @override
  AddSeanceState createState() => AddSeanceState();
}

class AddSeanceState extends State<AddSeanceScreen> {
  @override
  Widget build(BuildContext context) {
    return Form(
        child: Column(
      children: [
        TextFormField(
          decoration: const InputDecoration(
              labelText: 'Nom de la séance',
              hintText: 'Entrez le nom de la séance'),
        )
      ],
    ));
  }
}
