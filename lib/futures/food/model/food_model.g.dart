// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'food_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class FoodModelAdapter extends TypeAdapter<FoodModel> {
  @override
  final int typeId = 0;

  @override
  FoodModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return FoodModel(
      id: fields[0] as int?,
      typeOfFood: fields[1] as FoodType,
      name: fields[9] as String,
      date: fields[2] as DateTime,
      quantity: fields[3] as int,
      quantityType: fields[4] as Quantity,
      calories: fields[5] as int,
      proteins: fields[6] as double,
      fats: fields[7] as double,
      carbs: fields[8] as double,
    );
  }

  @override
  void write(BinaryWriter writer, FoodModel obj) {
    writer
      ..writeByte(10)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.typeOfFood)
      ..writeByte(2)
      ..write(obj.date)
      ..writeByte(3)
      ..write(obj.quantity)
      ..writeByte(4)
      ..write(obj.quantityType)
      ..writeByte(5)
      ..write(obj.calories)
      ..writeByte(6)
      ..write(obj.proteins)
      ..writeByte(7)
      ..write(obj.fats)
      ..writeByte(8)
      ..write(obj.carbs)
      ..writeByte(9)
      ..write(obj.name);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FoodModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class FoodTypeAdapter extends TypeAdapter<FoodType> {
  @override
  final int typeId = 2;

  @override
  FoodType read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return FoodType.breakfast;
      case 1:
        return FoodType.lunch;
      case 2:
        return FoodType.dinner;
      case 3:
        return FoodType.snack;
      default:
        return FoodType.breakfast;
    }
  }

  @override
  void write(BinaryWriter writer, FoodType obj) {
    switch (obj) {
      case FoodType.breakfast:
        writer.writeByte(0);
        break;
      case FoodType.lunch:
        writer.writeByte(1);
        break;
      case FoodType.dinner:
        writer.writeByte(2);
        break;
      case FoodType.snack:
        writer.writeByte(3);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FoodTypeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class QuantityAdapter extends TypeAdapter<Quantity> {
  @override
  final int typeId = 1;

  @override
  Quantity read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return Quantity.G;
      case 1:
        return Quantity.ml;
      case 2:
        return Quantity.lb;
      case 3:
        return Quantity.tsp;
      case 4:
        return Quantity.tbsp;
      case 5:
        return Quantity.cup;
      default:
        return Quantity.G;
    }
  }

  @override
  void write(BinaryWriter writer, Quantity obj) {
    switch (obj) {
      case Quantity.G:
        writer.writeByte(0);
        break;
      case Quantity.ml:
        writer.writeByte(1);
        break;
      case Quantity.lb:
        writer.writeByte(2);
        break;
      case Quantity.tsp:
        writer.writeByte(3);
        break;
      case Quantity.tbsp:
        writer.writeByte(4);
        break;
      case Quantity.cup:
        writer.writeByte(5);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is QuantityAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
