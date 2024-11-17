import 'package:tt_18/futures/main/day_goal_add/model/day_goal_model_hive.dart';

class DayGoalState {
  List<DayGoalModelHive?> dayGoalList;
  bool isLoading;
  DateTime? currentDate;

  DayGoalState({
    this.dayGoalList = const [],
    this.isLoading = true,
    this.currentDate,
  });
}
