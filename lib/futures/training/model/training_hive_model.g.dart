// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'training_hive_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TrainingHiveModelAdapter extends TypeAdapter<TrainingHiveModel> {
  @override
  final int typeId = 5;

  @override
  TrainingHiveModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TrainingHiveModel(
      id: fields[0] as int?,
      name: fields[1] as String,
      description: fields[2] as String,
      reireration: (fields[3] as List).cast<int>(),
      numberOfRep: fields[6] as int,
      restTime: fields[5] as int,
      workingTime: fields[4] as int,
      trainingType: fields[7] as TrainingType,
      completedDates: (fields[8] as List).cast<DateTime>(),
    );
  }

  @override
  void write(BinaryWriter writer, TrainingHiveModel obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.description)
      ..writeByte(3)
      ..write(obj.reireration)
      ..writeByte(4)
      ..write(obj.workingTime)
      ..writeByte(5)
      ..write(obj.restTime)
      ..writeByte(6)
      ..write(obj.numberOfRep)
      ..writeByte(7)
      ..write(obj.trainingType)
      ..writeByte(8)
      ..write(obj.completedDates);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TrainingHiveModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class TrainingTypeAdapter extends TypeAdapter<TrainingType> {
  @override
  final int typeId = 6;

  @override
  TrainingType read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TrainingType(
      id: fields[0] as int,
      name: fields[1] as String,
      imagePath: fields[2] as String,
    );
  }

  @override
  void write(BinaryWriter writer, TrainingType obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.imagePath);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TrainingTypeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
