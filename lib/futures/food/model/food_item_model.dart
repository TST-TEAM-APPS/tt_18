import 'package:tt_18/futures/food/model/food_model.dart';

class FoodItemModel {
  final String imageath;
  final String title;
  final FoodType type;

  FoodItemModel({
    required this.imageath,
    required this.title,
    required this.type,
  });
}

final List<FoodItemModel> foodItemList = [
  FoodItemModel(
    imageath: 'assets/icons/breakfest.png',
    title: 'Breakfest',
    type: FoodType.breakfast,
  ),
  FoodItemModel(
    imageath: 'assets/icons/lunch.png',
    title: 'Lunch',
    type: FoodType.lunch,
  ),
  FoodItemModel(
    imageath: 'assets/icons/snack.png',
    title: 'Snack',
    type: FoodType.snack,
  ),
  FoodItemModel(
    imageath: 'assets/icons/dinner.png',
    title: 'Dinner',
    type: FoodType.dinner,
  ),
];

class DropDownModel {
  final Quantity quantity;
  final String title;

  DropDownModel({required this.quantity, required this.title});
}

final List<DropDownModel> dropDownModelList = [
  DropDownModel(quantity: Quantity.G, title: 'G'),
  DropDownModel(quantity: Quantity.ml, title: 'ml'),
  DropDownModel(quantity: Quantity.lb, title: 'lb'),
  DropDownModel(quantity: Quantity.tsp, title: 'tsp'),
  DropDownModel(quantity: Quantity.tbsp, title: 'tbsp'),
  DropDownModel(quantity: Quantity.cup, title: 'cup'),
];
