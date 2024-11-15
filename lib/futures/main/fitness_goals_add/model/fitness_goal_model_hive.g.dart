// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fitness_goal_model_hive.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class FitnessGoalModelHiveAdapter extends TypeAdapter<FitnessGoalModelHive> {
  @override
  final int typeId = 3;

  @override
  FitnessGoalModelHive read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return FitnessGoalModelHive(
      id: fields[0] as int?,
      imagePath: fields[1] as String,
      name: fields[2] as String,
      startedDate: fields[3] as DateTime,
      endedDate: fields[4] as DateTime,
      currentProgress: fields[5] as int?,
      goal: fields[6] as int?,
      description: fields[7] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, FitnessGoalModelHive obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.imagePath)
      ..writeByte(2)
      ..write(obj.name)
      ..writeByte(3)
      ..write(obj.startedDate)
      ..writeByte(4)
      ..write(obj.endedDate)
      ..writeByte(5)
      ..write(obj.currentProgress)
      ..writeByte(6)
      ..write(obj.goal)
      ..writeByte(7)
      ..write(obj.description);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FitnessGoalModelHiveAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
