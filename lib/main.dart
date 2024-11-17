import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tt_18/futures/food/model/food_model.dart';

import 'package:tt_18/core/colors.dart';
import 'package:tt_18/futures/home/home_screen.dart';
import 'package:tt_18/futures/main/day_goal_add/model/day_goal_model_hive.dart';
import 'package:tt_18/futures/main/fitness_goals_add/model/fitness_goal_model_hive.dart';
import 'package:tt_18/futures/onboarding/onb_screen.dart';
import 'package:tt_18/futures/training/model/training_hive_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(FoodModelAdapter());
  Hive.registerAdapter(FoodTypeAdapter());
  Hive.registerAdapter(QuantityAdapter());
  Hive.registerAdapter(FitnessGoalModelHiveAdapter());
  Hive.registerAdapter(DayGoalModelHiveAdapter());
  Hive.registerAdapter(TrainingHiveModelAdapter());
  Hive.registerAdapter(TrainingTypeAdapter());
  await Future.delayed(const Duration(seconds: 2));
  final prefs = await SharedPreferences.getInstance();
  final showOnb = prefs.getBool('showOnb') ?? true;
  runApp(MyApp(
    homeScreen: showOnb ? const Onb() : const HomeScreen(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.homeScreen});

  final Widget homeScreen;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'tt_18',
      theme: ThemeData(
        scaffoldBackgroundColor: AppColors.background,
        highlightColor: Colors.transparent,
        splashColor: Colors.transparent,
        bottomSheetTheme:
            const BottomSheetThemeData(backgroundColor: Colors.transparent),
        splashFactory: NoSplash.splashFactory,
      ),
      home: homeScreen,
    );
  }
}
