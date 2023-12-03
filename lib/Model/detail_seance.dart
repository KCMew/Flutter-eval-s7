import 'package:hive/hive.dart';

part 'detail_seance.g.dart';

@HiveType(typeId: 2)
class DetailSeance {
  @HiveField(0)
  String nomSeance;
  @HiveField(1)
  String nomExo;
  @HiveField(2)
  int? nbRepetition;
  @HiveField(3)
  int? nbSerie;

  DetailSeance(
      {required this.nomSeance,
      required this.nomExo,
      required this.nbRepetition,
      required this.nbSerie});
}
