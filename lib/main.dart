import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:tt_18/futures/food/model/food_model.dart';

import 'package:tt_18/core/colors.dart';
import 'package:tt_18/futures/main/fitness_goals_add/model/fitness_goal_model_hive.dart';
import 'package:tt_18/futures/onboarding/onb_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(FoodModelAdapter());
  Hive.registerAdapter(FoodTypeAdapter());
  Hive.registerAdapter(QuantityAdapter());
  Hive.registerAdapter(FitnessGoalModelHiveAdapter());
  runApp(const MyApp(
    homeScreen: Onb(),
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
