import 'package:flutter/material.dart';
import 'package:tt_18/futures/main/fitness_goals_add/logic/services/fitness_goal_model_service.dart';
import 'package:tt_18/futures/main/fitness_goals_add/logic/state/fitness_goal_state.dart';
import 'package:tt_18/futures/main/fitness_goals_add/model/fitness_goal_model_hive.dart';

class ActivityViewModel extends ChangeNotifier {
  final FitnessGoalModelService _fitnessGoalModelService =
      FitnessGoalModelService();
  FitnessGoalState _fitnessState = FitnessGoalState();
  FitnessGoalState get fitnessState => _fitnessState;

  void loadData() async {
    await _fitnessGoalModelService.loadData();
    _fitnessState = FitnessGoalState(
      fitnessGoalList: _fitnessGoalModelService.fitnessGoalList,
    );
    print(_fitnessGoalModelService.fitnessGoalList);
    notifyListeners();
  }

  ActivityViewModel() {
    print('asdfasdf');
    loadData();
  }

  void onDeleteFitnessGoal(FitnessGoalModelHive fitnessGoalModel) async {
    await _fitnessGoalModelService.deleteFitnessGoal(fitnessGoalModel);
    _fitnessState = FitnessGoalState(
      fitnessGoalList: _fitnessGoalModelService.fitnessGoalList,
    );
    notifyListeners();
  }

  void onUpdatedFitnessGoal(FitnessGoalModelHive fitnessGoalModel) {
    _fitnessGoalModelService.editFitnessGoal(fitnessGoalModel).then((_) {
      _fitnessState = FitnessGoalState(
        fitnessGoalList: _fitnessGoalModelService.fitnessGoalList,
      );
    });
    notifyListeners();
  }

  void onUpdatedDate(DateTime date) {
    _fitnessGoalModelService.updateDate(date).then((_) {
      _fitnessState = FitnessGoalState(
        fitnessGoalList: _fitnessGoalModelService.fitnessGoalList,
      );
    });

    notifyListeners();
  }

  Future<void> onFitnessGoalItemAdded(
      FitnessGoalModelHive fitnessGoalModel) async {
    _fitnessGoalModelService.setFitnessGoal(fitnessGoalModel).then((_) {
      _fitnessState = FitnessGoalState(
        fitnessGoalList: _fitnessGoalModelService.fitnessGoalList,
      );
      notifyListeners();
    });
  }
}
