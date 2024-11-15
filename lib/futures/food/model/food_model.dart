// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:hive/hive.dart';

part 'food_model.g.dart';

@HiveType(typeId: 2)
enum FoodType {
  @HiveField(0)
  breakfast,
  @HiveField(1)
  lunch,
  @HiveField(2)
  dinner,
  @HiveField(3)
  snack,
}

@HiveType(typeId: 1)
enum Quantity {
  @HiveField(0)
  G,
  @HiveField(1)
  ml,
  @HiveField(2)
  lb,
  @HiveField(3)
  tsp,
  @HiveField(4)
  tbsp,
  @HiveField(5)
  cup,
}

@HiveType(typeId: 0)
class FoodModel extends HiveObject {
  @HiveField(0)
  final int id;
  @HiveField(1)
  final FoodType typeOfFood;
  @HiveField(2)
  final DateTime date;
  @HiveField(3)
  final int quantity;
  @HiveField(4)
  final Quantity quantityType;
  @HiveField(5)
  final int calories;
  @HiveField(6)
  final double proteins;
  @HiveField(7)
  final double fats;
  @HiveField(8)
  final double carbs;
  @HiveField(9)
  final String name;

  FoodModel(
      {int? id,
      required this.typeOfFood,
      required this.name,
      required this.date,
      required this.quantity,
      required this.quantityType,
      required this.calories,
      required this.proteins,
      required this.fats,
      required this.carbs})
      : id = id ?? DateTime.now().microsecondsSinceEpoch;
  @override
  bool operator ==(covariant FoodModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.typeOfFood == typeOfFood &&
        other.date == date &&
        other.quantity == quantity &&
        other.quantityType == quantityType &&
        other.calories == calories &&
        other.proteins == proteins &&
        other.fats == fats &&
        other.carbs == carbs;
  }

  FoodModel copyWith({
    int? id,
    FoodType? typeOfFood,
    DateTime? date,
    int? quantity,
    Quantity? quantityType,
    int? calories,
    double? proteins,
    double? fats,
    double? carbs,
    String? name,
  }) {
    return FoodModel(
      id: this.id,
      typeOfFood: typeOfFood ?? this.typeOfFood,
      name: name ?? this.name,
      date: date ?? this.date,
      quantity: quantity ?? this.quantity,
      quantityType: quantityType ?? this.quantityType,
      calories: calories ?? this.calories,
      proteins: proteins ?? this.proteins,
      fats: fats ?? this.fats,
      carbs: carbs ?? this.carbs,
    );
  }
}
