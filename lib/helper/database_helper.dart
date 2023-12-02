import 'package:evals7/Model/seance.dart';
import 'package:evals7/helper/boxes.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

class DatabaseHelper {
  static const seanceTable = "seance";

  static Future<void> setupDatabase() async {
    await Hive.initFlutter();
    Hive.registerAdapter(SeanceAdapter());
    boxSeance = await Hive.openBox<Seance>(seanceTable);
  }

  /*  static Future<void> addSeance(String nomSeance, String jour) async {
    boxSeance = await Hive.openBox<Seance>(seanceTable);
    await box.add(Seance(nomSeance: nomSeance, jourSeance: jour));
  }

  static Future<List<Seance>> getAllSeance() async {
    final box = await Hive.openBox<Seance>(seanceTable);
    return box.values.toList();
  } */
}
