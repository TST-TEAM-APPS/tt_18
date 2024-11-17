// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'day_goal_model_hive.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class DayGoalModelHiveAdapter extends TypeAdapter<DayGoalModelHive> {
  @override
  final int typeId = 4;

  @override
  DayGoalModelHive read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return DayGoalModelHive(
      id: fields[0] as int?,
      name: fields[1] as String,
      description: fields[2] as String,
      isDone: (fields[5] as List).cast<DateTime>(),
      reireration: (fields[3] as List).cast<int>(),
      tag: fields[4] as String,
    );
  }

  @override
  void write(BinaryWriter writer, DayGoalModelHive obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.description)
      ..writeByte(3)
      ..write(obj.reireration)
      ..writeByte(4)
      ..write(obj.tag)
      ..writeByte(5)
      ..write(obj.isDone);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DayGoalModelHiveAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
