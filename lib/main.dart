import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:tt_18/futures/food/model/food_model.dart';

import 'package:tt_18/core/colors.dart';
import 'package:tt_18/futures/main/day_goal_add/model/day_goal_model_hive.dart';
import 'package:tt_18/futures/main/fitness_goals_add/model/fitness_goal_model_hive.dart';
import 'package:tt_18/futures/onboarding/splash_screen.dart';
import 'package:tt_18/futures/training/model/training_hive_model.dart';
import 'package:tt_18/services/config_service.dart';
import 'package:tt_18/services/locator.dart';

void main() async {
  final bindings = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: bindings);
  await _init();
  runApp(const MyApp());
}

Future<void> _init() async {
  await Locator.setup();
  addLifecycleHandler();
  await Hive.initFlutter();
  Hive.registerAdapter(FoodModelAdapter());
  Hive.registerAdapter(FoodTypeAdapter());
  Hive.registerAdapter(QuantityAdapter());
  Hive.registerAdapter(FitnessGoalModelHiveAdapter());
  Hive.registerAdapter(DayGoalModelHiveAdapter());
  Hive.registerAdapter(TrainingHiveModelAdapter());
  Hive.registerAdapter(TrainingTypeAdapter());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'MuscleDieta Power - Dashboard',
      theme: ThemeData(
        scaffoldBackgroundColor: AppColors.background,
        highlightColor: Colors.transparent,
        splashColor: Colors.transparent,
        bottomSheetTheme:
            const BottomSheetThemeData(backgroundColor: Colors.transparent),
        splashFactory: NoSplash.splashFactory,
      ),
      home: const SplashScreen(),
    );
  }
}

void addLifecycleHandler() {
  WidgetsBinding.instance.addObserver(
    AppLifecycleListener(onDetach: GetIt.instance<ConfigService>().closeClient),
  );
}
