// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'seance.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SeanceAdapter extends TypeAdapter<Seance> {
  @override
  final int typeId = 1;

  @override
  Seance read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Seance(
      key: fields[0] as String,
      nomSeance: fields[1] as String,
      jourSeance: fields[2] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Seance obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.key)
      ..writeByte(1)
      ..write(obj.nomSeance)
      ..writeByte(2)
      ..write(obj.jourSeance);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SeanceAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
