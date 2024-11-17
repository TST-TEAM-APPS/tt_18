import 'package:tt_18/futures/main/fitness_goals_add/model/fitness_goal_model_hive.dart';

class FitnessGoalState {
  List<FitnessGoalModelHive?> fitnessGoalList;
  bool isLoading;

  FitnessGoalState({
    this.isLoading = true,
    this.fitnessGoalList = const [],
  });
}
