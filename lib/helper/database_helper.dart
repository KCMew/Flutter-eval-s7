// ignore_for_file: unnecessary_import

import 'package:evals7/Model/detail_seance.dart';
import 'package:evals7/Model/seance.dart';
import 'package:evals7/helper/boxes.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

class DatabaseHelper {
  static const seanceTable = "seance";
  static const detailSeanceTable = "detailseance";
  static const parametreTable = "parametre";
  static const statistiqueTable = "statistique";

  static Future<void> setupDatabaseSeance() async {
    await Hive.initFlutter();
    Hive.registerAdapter(SeanceAdapter());
    boxSeance = await Hive.openBox<Seance>(seanceTable);
  }

  static Future<void> setupDatabaseDetailSeance() async {
    await Hive.initFlutter();
    Hive.registerAdapter(DetailSeanceAdapter());
    boxDetailSeance = await Hive.openBox<DetailSeance>(detailSeanceTable);
  }

  static Future<void> setupDatabaseParametre() async {
    await Hive.initFlutter();
    boxParametre = await Hive.openBox(parametreTable);
  }

  static Future<void> setupDatabaseStatistique() async {
    await Hive.initFlutter();
    boxStatistique = await Hive.openBox(statistiqueTable);
  }
}
