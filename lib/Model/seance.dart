import 'package:hive/hive.dart';

part 'seance.g.dart';

@HiveType(typeId: 1)
class Seance {
  @HiveField(0)
  String nomSeance;
  @HiveField(1)
  String jourSeance;

  Seance({required this.nomSeance, required this.jourSeance});
}
