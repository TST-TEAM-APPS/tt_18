import 'package:hive/hive.dart';
import 'package:tt_18/futures/main/fitness_goals_add/model/fitness_goal_model_hive.dart';

class FitnessGoalModelService {
  List<FitnessGoalModelHive?> _fitnessGoalList = [];

  DateTime _dateTime = DateTime.now();

  DateTime? get currentDateTime => _dateTime;
  List<FitnessGoalModelHive?> get fitnessGoalList => _fitnessGoalList;

  Future<void> loadData() async {
    final foodModelBox =
        await Hive.openBox<FitnessGoalModelHive>('_fitnessGoalList');
    _fitnessGoalList = foodModelBox.values.toList();
    // await update();
  }

  // Future<void> update() async {

  // }

  Future<void> updateDate(DateTime date) async {
    _dateTime = date;
    await loadData();
  }

  Future<void> setFitnessGoal(FitnessGoalModelHive fitnessGoalModel) async {
    final fitnessGoalModelBox =
        await Hive.openBox<FitnessGoalModelHive>('_fitnessGoalList');
    await fitnessGoalModelBox.add(fitnessGoalModel);
    _fitnessGoalList.add(fitnessGoalModel);
    await loadData();
  }

  Future<void> deleteFitnessGoal(FitnessGoalModelHive fitnessGoalModel) async {
    final fitnessGoalModelBox =
        await Hive.openBox<FitnessGoalModelHive>('_fitnessGoalList');
    final fitnessGoalList = fitnessGoalModelBox.values.toList();
    if (fitnessGoalList.contains(fitnessGoalModel)) {
      _fitnessGoalList.remove(fitnessGoalModel);
      await fitnessGoalModelBox.delete(fitnessGoalModel);
    }
    await loadData();
  }

  Future<void> editFitnessGoal(FitnessGoalModelHive fitnessGoalModel) async {
    final fitnessGoalModelBox =
        await Hive.openBox<FitnessGoalModelHive>('_fitnessGoalList');

    int foodToUpdateIndex = _fitnessGoalList.indexWhere((food) {
      return food?.id == fitnessGoalModel.id;
    });
    if (foodToUpdateIndex != -1) {
      _fitnessGoalList[foodToUpdateIndex] = fitnessGoalModel;
    }

    final newValue = _fitnessGoalList[foodToUpdateIndex]!.copyWith(
      name: fitnessGoalModel.name,
      description: fitnessGoalModel.description,
      imagePath: fitnessGoalModel.imagePath,
      currentProgress: fitnessGoalModel.currentProgress,
      goal: fitnessGoalModel.goal,
      startedDate: fitnessGoalModel.startedDate,
      endedDate: fitnessGoalModel.endedDate,
    );

    await fitnessGoalModelBox.put(newValue.id.toString(), newValue);
    await loadData();
  }

  // Future<List<FoodModel?>?> getBreakfestList(DateTime date) async {
  //   final foodModelList = _fitnessGoalList;
  //   if (foodModelList.isEmpty) {
  //     return null;
  //   }

  //   final filteredModelList = foodModelList.where((value) {
  //     return DateTime(value!.date.day, value.date.month, value.date.year)
  //             .isAtSameMomentAs(DateTime(date.day, date.month, date.year)) &&
  //         value.typeOfFood == FoodType.breakfast;
  //   }).toList();
  //   if (filteredModelList.isNotEmpty) {
  //     filteredModelList.sort((a, b) => b!.date.compareTo(a!.date));
  //     return filteredModelList;
  //   }
  //   return null;
  // }

  // Future<List<FoodModel?>?> getLunchList(DateTime date) async {
  //   final foodModelList = _fitnessGoalList;
  //   if (foodModelList.isEmpty) {
  //     return null;
  //   }
  //   final filteredModelList = foodModelList.where((value) {
  //     return DateTime(value!.date.day, value.date.month, value.date.year)
  //             .isAtSameMomentAs(DateTime(date.day, date.month, date.year)) &&
  //         value.typeOfFood == FoodType.lunch;
  //   }).toList();
  //   if (filteredModelList.isNotEmpty) {
  //     return filteredModelList..sort((a, b) => b!.date.compareTo(a!.date));
  //   }
  //   return null;
  // }

  // Future<int> getTotalCalories(DateTime date) async {
  //   final foodModelList = _fitnessGoalList.where((value) {
  //     return DateTime(value!.date.day, value.date.month, value.date.year)
  //         .isAtSameMomentAs(DateTime(date.day, date.month, date.year));
  //   }).toList();
  //   if (foodModelList.isEmpty) {
  //     return 0;
  //   }
  //   return foodModelList.fold<int>(0, (sum, item) => sum + item!.calories);
  // }

  // Future<double> getTotalCarbs(DateTime date) async {
  //   final foodModelList = _fitnessGoalList.where((value) {
  //     return DateTime(value!.date.day, value.date.month, value.date.year)
  //         .isAtSameMomentAs(DateTime(date.day, date.month, date.year));
  //   }).toList();
  //   if (foodModelList.isEmpty) {
  //     return 0;
  //   }
  //   return foodModelList.fold<double>(0, (sum, item) => sum + item!.carbs);
  // }

  // Future<double> getTotalProteins(DateTime date) async {
  //   final foodModelList = _fitnessGoalList.where((value) {
  //     return DateTime(value!.date.day, value.date.month, value.date.year)
  //         .isAtSameMomentAs(DateTime(date.day, date.month, date.year));
  //   }).toList();
  //   if (foodModelList.isEmpty) {
  //     return 0;
  //   }
  //   return foodModelList.fold<double>(0, (sum, item) => sum + item!.proteins);
  // }

  // Future<double> getTotalFats(DateTime date) async {
  //   final foodModelList = _fitnessGoalList.where((value) {
  //     return DateTime(value!.date.day, value.date.month, value.date.year)
  //         .isAtSameMomentAs(DateTime(date.day, date.month, date.year));
  //   }).toList();
  //   if (foodModelList.isEmpty) {
  //     return 0;
  //   }
  //   return foodModelList.fold<double>(0, (sum, item) => sum + item!.fats);
  // }

  // Future<List<FoodModel?>?> getDinnerList(DateTime date) async {
  //   final foodModelList = _fitnessGoalList;
  //   if (foodModelList.isEmpty) {
  //     return null;
  //   }

  //   final filteredModelList = foodModelList.where((value) {
  //     return DateTime(value!.date.day, value.date.month, value.date.year)
  //             .isAtSameMomentAs(DateTime(date.day, date.month, date.year)) &&
  //         value.typeOfFood == FoodType.dinner;
  //   }).toList();
  //   if (filteredModelList.isNotEmpty) {
  //     return filteredModelList..sort((a, b) => b!.date.compareTo(a!.date));
  //   }
  //   return null;
  // }

  // Future<List<FoodModel?>?> getSnackList(DateTime date) async {
  //   final foodModelList = _fitnessGoalList;
  //   if (foodModelList.isEmpty) {
  //     return null;
  //   }

  //   final filteredModelList = foodModelList.where((value) {
  //     return DateTime(value!.date.day, value.date.month, value.date.year)
  //             .isAtSameMomentAs(DateTime(date.day, date.month, date.year)) &&
  //         value.typeOfFood == FoodType.snack;
  //   }).toList();
  //   if (filteredModelList.isNotEmpty) {
  //     return filteredModelList..sort((a, b) => b!.date.compareTo(a!.date));
  //   }
  //   return null;
  // }
}
