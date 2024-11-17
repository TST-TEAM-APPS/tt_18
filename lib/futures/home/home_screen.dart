import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tt_18/core/app_fonts.dart';
import 'package:tt_18/core/btm.dart';
import 'package:tt_18/core/colors.dart';
import 'package:tt_18/futures/food/food_screen.dart';
import 'package:tt_18/futures/food/model/food_model.dart';
import 'package:tt_18/futures/main/view_model/activity_view_model.dart';
import 'package:tt_18/futures/main/main_screen.dart';
import 'package:tt_18/futures/settings/settings_screen.dart';
import 'package:tt_18/futures/training/training_screen.dart';
import 'package:tt_18/futures/training/view_model/training_view_model.dart';

class FoodViewModelState {
  List<FoodModel?>? foodBreakfestList;
  List<FoodModel?>? foodLunchList;
  List<FoodModel?>? foodDinnerList;
  List<FoodModel?>? foodSnakList;
  int? totalCalories;
  double? totalProteins;
  double? totalFats;
  double? totalCarbs;
  DateTime? currentDateTime;
  int? calorieGoal;

  FoodViewModelState({
    this.totalCalories,
    this.foodBreakfestList,
    this.foodDinnerList,
    this.foodLunchList,
    this.foodSnakList,
    this.totalCarbs,
    this.totalFats,
    this.totalProteins,
    this.currentDateTime,
    this.calorieGoal,
  });
}

class FoodViewModel extends ChangeNotifier {
  final FoodService _foodService = FoodService();
  FoodViewModelState _state = FoodViewModelState();
  FoodViewModelState get state => _state;

  void loadData() async {
    await _foodService.loadData();
    _state = FoodViewModelState(
      foodBreakfestList: _foodService._foodBreakfestList,
      foodDinnerList: _foodService._foodDinnerList,
      foodLunchList: _foodService._foodLunchList,
      foodSnakList: _foodService._foodLunchList,
      totalCalories: _foodService._totalCalories,
      totalCarbs: _foodService._totalCarbs,
      totalFats: _foodService.totalFats,
      totalProteins: _foodService._totalProteins,
      currentDateTime: _foodService._dateTime,
      calorieGoal: _foodService._calorieGoal,
    );
    notifyListeners();
  }

  FoodViewModel() {
    loadData();
  }

  void onSetCalorie(int number) async {
    await _foodService.setCalorieGoal(number);
    _state = _state = FoodViewModelState(
      foodBreakfestList: _foodService._foodBreakfestList,
      foodDinnerList: _foodService._foodDinnerList,
      foodLunchList: _foodService._foodLunchList,
      foodSnakList: _foodService._foodLunchList,
      totalCalories: _foodService._totalCalories,
      totalCarbs: _foodService._totalCarbs,
      totalFats: _foodService.totalFats,
      totalProteins: _foodService._totalProteins,
      currentDateTime: _foodService._dateTime,
      calorieGoal: _foodService._calorieGoal,
    );

    notifyListeners();
  }

  void onDeleteFood(FoodModel foodModel) async {
    await _foodService.deleteFood(foodModel);
    _state = FoodViewModelState(
      foodBreakfestList: _foodService._foodBreakfestList,
      foodDinnerList: _foodService._foodDinnerList,
      foodLunchList: _foodService._foodLunchList,
      foodSnakList: _foodService._foodLunchList,
      totalCalories: _foodService._totalCalories,
      totalCarbs: _foodService._totalCarbs,
      totalFats: _foodService.totalFats,
      totalProteins: _foodService._totalProteins,
      currentDateTime: _foodService._dateTime,
      calorieGoal: _foodService._calorieGoal,
    );
    notifyListeners();
  }

  void onUpdatedFood(FoodModel foodModel) {
    _foodService.editFood(foodModel).then((_) {
      _state = FoodViewModelState(
        foodBreakfestList: _foodService._foodBreakfestList,
        foodDinnerList: _foodService._foodDinnerList,
        foodLunchList: _foodService._foodLunchList,
        foodSnakList: _foodService._foodSnakList,
        totalCalories: _foodService._totalCalories,
        totalCarbs: _foodService._totalCarbs,
        totalFats: _foodService._totalFats,
        totalProteins: _foodService._totalProteins,
        currentDateTime: _foodService._dateTime,
        calorieGoal: _foodService._calorieGoal,
      );
    });
    notifyListeners();
  }

  void onUpdatedDate(DateTime date) {
    _foodService.updateDate(date).then((_) {
      _state = FoodViewModelState(
        foodBreakfestList: _foodService._foodBreakfestList,
        foodDinnerList: _foodService._foodDinnerList,
        foodLunchList: _foodService._foodLunchList,
        foodSnakList: _foodService._foodSnakList,
        totalCalories: _foodService._totalCalories,
        totalCarbs: _foodService._totalCarbs,
        totalFats: _foodService._totalFats,
        totalProteins: _foodService._totalProteins,
        currentDateTime: _foodService._dateTime,
        calorieGoal: _foodService._calorieGoal,
      );
    });

    notifyListeners();
  }

  Future<void> onFoodItemAdded(FoodModel foodModel) async {
    _foodService.setFood(foodModel).then((_) {
      _state = FoodViewModelState(
        foodBreakfestList: _foodService._foodBreakfestList,
        foodDinnerList: _foodService._foodDinnerList,
        foodLunchList: _foodService._foodLunchList,
        foodSnakList: _foodService._foodSnakList,
        totalCalories: _foodService._totalCalories,
        totalCarbs: _foodService._totalCarbs,
        totalFats: _foodService._totalFats,
        totalProteins: _foodService._totalProteins,
        currentDateTime: _foodService._dateTime,
        calorieGoal: _foodService._calorieGoal,
      );
      notifyListeners();
    });
  }
}

class FoodService {
  List<FoodModel?> _foodList = [];
  List<FoodModel?>? _foodBreakfestList;
  List<FoodModel?>? _foodLunchList;
  List<FoodModel?>? _foodDinnerList;
  List<FoodModel?>? _foodSnakList;
  int? _totalCalories;
  double? _totalProteins;
  double? _totalCarbs;
  double? _totalFats;
  int? _calorieGoal;

  DateTime _dateTime = DateTime.now();

  List<FoodModel?>? get foodBreakfestList => _foodBreakfestList;
  List<FoodModel?>? get foodLunchList => _foodLunchList;
  List<FoodModel?>? get foodDinnerList => _foodDinnerList;
  List<FoodModel?>? get foodSnakList => _foodSnakList;
  int? get calorieGoal => _calorieGoal;

  int? get totalCalories => _totalCalories;
  double? get totalProteins => _totalProteins;
  double? get totalCarbs => _totalCarbs;
  double? get totalFats => _totalFats;
  DateTime? get currentDateTime => _dateTime;

  Future<void> loadData() async {
    final foodModelBox = await Hive.openBox<FoodModel>('_foodList');
    _foodList = foodModelBox.values.toList();

    await update();
  }

  Future<void> update() async {
    final foodModelBox = await Hive.openBox<FoodModel>('_foodList');
    _foodList = foodModelBox.values.toList();
    _foodBreakfestList = await getBreakfestList(_dateTime);
    _foodLunchList = await getLunchList(_dateTime);
    _foodDinnerList = await getDinnerList(_dateTime);
    _foodSnakList = await getSnackList(_dateTime);
    _totalCalories = await getTotalCalories(_dateTime);
    _totalCarbs = await getTotalCarbs(_dateTime);
    _totalFats = await getTotalFats(_dateTime);
    _totalProteins = await getTotalProteins(_dateTime);
    _calorieGoal = await getCalorieGoal();
  }

  Future<int> getCalorieGoal() async {
    final prefs = await SharedPreferences.getInstance();
    final result = prefs.getInt('calorieGoal') ?? 0;
    return result;
  }

  Future<void> setCalorieGoal(int a) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setInt('calorieGoal', a);
    _calorieGoal = await getCalorieGoal();
  }

  Future<void> updateDate(DateTime date) async {
    _dateTime = date;
    await update();
  }

  Future<void> setFood(FoodModel foodModel) async {
    final foodModelBox = await Hive.openBox<FoodModel>('_foodList');
    await foodModelBox.add(foodModel);

    await update();
  }

  Future<void> deleteFood(FoodModel foodModel) async {
    final foodModelBox = await Hive.openBox<FoodModel>('_foodList');

    final element =
        foodModelBox.values.toList().singleWhere((e) => e.id == foodModel.id);
    await element.delete();
    await foodModelBox.compact();

    await update();
  }

  Future<void> editFood(FoodModel employeEditModel) async {
    final foodModelBox = await Hive.openBox<FoodModel>('_foodList');
    FoodModel newMoaqw =
        foodModelBox.values.singleWhere((e) => e.id == employeEditModel.id);

    newMoaqw.name = employeEditModel.name;
    newMoaqw.typeOfFood = employeEditModel.typeOfFood;
    newMoaqw.quantity = employeEditModel.quantity;
    newMoaqw.quantityType = employeEditModel.quantityType;
    newMoaqw.proteins = employeEditModel.proteins;
    newMoaqw.fats = employeEditModel.fats;
    newMoaqw.carbs = employeEditModel.carbs;
    newMoaqw.calories = employeEditModel.calories;

    await newMoaqw.save();
    await update();
  }

  Future<List<FoodModel?>?> getBreakfestList(DateTime date) async {
    final foodModelList = _foodList;
    if (foodModelList.isEmpty) {
      return null;
    }

    final filteredModelList = foodModelList.where((value) {
      return DateTime(value!.date.day, value.date.month, value.date.year)
              .isAtSameMomentAs(DateTime(date.day, date.month, date.year)) &&
          value.typeOfFood == FoodType.breakfast;
    }).toList();
    if (filteredModelList.isNotEmpty) {
      filteredModelList.sort((a, b) => b!.date.compareTo(a!.date));
      return filteredModelList;
    }
    return null;
  }

  Future<List<FoodModel?>?> getLunchList(DateTime date) async {
    final foodModelList = _foodList;
    if (foodModelList.isEmpty) {
      return null;
    }
    final filteredModelList = foodModelList.where((value) {
      return DateTime(value!.date.day, value.date.month, value.date.year)
              .isAtSameMomentAs(DateTime(date.day, date.month, date.year)) &&
          value.typeOfFood == FoodType.lunch;
    }).toList();
    if (filteredModelList.isNotEmpty) {
      return filteredModelList..sort((a, b) => b!.date.compareTo(a!.date));
    }
    return null;
  }

  Future<int> getTotalCalories(DateTime date) async {
    final foodModelList = _foodList.where((value) {
      return DateTime(value!.date.day, value.date.month, value.date.year)
          .isAtSameMomentAs(DateTime(date.day, date.month, date.year));
    }).toList();
    if (foodModelList.isEmpty) {
      return 0;
    }
    return foodModelList.fold<int>(0, (sum, item) => sum + item!.calories);
  }

  Future<double> getTotalCarbs(DateTime date) async {
    final foodModelList = _foodList.where((value) {
      return DateTime(value!.date.day, value.date.month, value.date.year)
          .isAtSameMomentAs(DateTime(date.day, date.month, date.year));
    }).toList();
    if (foodModelList.isEmpty) {
      return 0;
    }
    return foodModelList.fold<double>(0, (sum, item) => sum + item!.carbs);
  }

  Future<double> getTotalProteins(DateTime date) async {
    final foodModelList = _foodList.where((value) {
      return DateTime(value!.date.day, value.date.month, value.date.year)
          .isAtSameMomentAs(DateTime(date.day, date.month, date.year));
    }).toList();
    if (foodModelList.isEmpty) {
      return 0;
    }
    return foodModelList.fold<double>(0, (sum, item) => sum + item!.proteins);
  }

  Future<double> getTotalFats(DateTime date) async {
    final foodModelList = _foodList.where((value) {
      return DateTime(value!.date.day, value.date.month, value.date.year)
          .isAtSameMomentAs(DateTime(date.day, date.month, date.year));
    }).toList();
    if (foodModelList.isEmpty) {
      return 0;
    }
    return foodModelList.fold<double>(0, (sum, item) => sum + item!.fats);
  }

  Future<List<FoodModel?>?> getDinnerList(DateTime date) async {
    final foodModelList = _foodList;
    if (foodModelList.isEmpty) {
      return null;
    }

    final filteredModelList = foodModelList.where((value) {
      return DateTime(value!.date.day, value.date.month, value.date.year)
              .isAtSameMomentAs(DateTime(date.day, date.month, date.year)) &&
          value.typeOfFood == FoodType.dinner;
    }).toList();
    if (filteredModelList.isNotEmpty) {
      return filteredModelList..sort((a, b) => b!.date.compareTo(a!.date));
    }
    return null;
  }

  Future<List<FoodModel?>?> getSnackList(DateTime date) async {
    final foodModelList = _foodList;
    if (foodModelList.isEmpty) {
      return null;
    }

    final filteredModelList = foodModelList.where((value) {
      return DateTime(value!.date.day, value.date.month, value.date.year)
              .isAtSameMomentAs(DateTime(date.day, date.month, date.year)) &&
          value.typeOfFood == FoodType.snack;
    }).toList();
    if (filteredModelList.isNotEmpty) {
      return filteredModelList..sort((a, b) => b!.date.compareTo(a!.date));
    }
    return null;
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  final List<PageModel> _pages = [
    PageModel(
      page: ChangeNotifierProvider(
          create: (_) => ActivityViewModel(), child: const MainScreen()),
      iconPath: 'assets/icons/main.png',
    ),
    PageModel(
      page: ChangeNotifierProvider(
          create: (_) => TrainingViewModel(), child: const TrainingScreen()),
      iconPath: 'assets/icons/training.png',
    ),
    PageModel(
      page: ChangeNotifierProvider(
          create: (_) => FoodViewModel(), child: const FoodScreen()),
      iconPath: 'assets/icons/food.png',
    ),
    PageModel(
      page: ChangeNotifierProvider(
          create: (_) => ActivityViewModel(), child: const SettingsScreen()),
      iconPath: 'assets/icons/settings.png',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex].page,
      bottomNavigationBar: WoDownBar(
        onPageChanged: (index) {
          _currentIndex = index;
          setState(() {});
        },
        pages: _pages,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            height: 48,
            width: 48,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (_pages[index].iconPath != null)
                  Image.asset(
                    _pages[index].iconPath!,
                    color: _currentIndex == index
                        ? AppColors.primary
                        : AppColors.outlineGrey,
                    width: 24,
                  ),
                if (_pages[index].title != null)
                  const SizedBox(
                    height: 3,
                  ),
                if (_pages[index].title != null)
                  Text(
                    _pages[index].title!,
                    style: AppFonts.displaySmall.copyWith(
                      color: _currentIndex == index
                          ? Colors.white
                          : AppColors.outlineGrey,
                    ),
                  )
              ],
            ),
          );
        },
      ),
    );
  }
}
