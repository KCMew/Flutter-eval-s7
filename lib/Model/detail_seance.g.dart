// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'detail_seance.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class DetailSeanceAdapter extends TypeAdapter<DetailSeance> {
  @override
  final int typeId = 2;

  @override
  DetailSeance read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return DetailSeance(
      nomSeance: fields[0] as String,
      nomExo: fields[1] as String,
      nbRepetition: fields[2] as int?,
      nbSerie: fields[3] as int?,
    );
  }

  @override
  void write(BinaryWriter writer, DetailSeance obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.nomSeance)
      ..writeByte(1)
      ..write(obj.nomExo)
      ..writeByte(2)
      ..write(obj.nbRepetition)
      ..writeByte(3)
      ..write(obj.nbSerie);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DetailSeanceAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
