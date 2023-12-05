import 'package:hive/hive.dart';

part 'seance.g.dart';

@HiveType(typeId: 1)
class Seance {
  @HiveField(0)
  String key;
  @HiveField(1)
  String nomSeance;
  @HiveField(2)
  String jourSeance;

  Seance(
      {required this.key, required this.nomSeance, required this.jourSeance});
}
