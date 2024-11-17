import 'package:flutter/material.dart';
import 'package:tt_18/futures/main/day_goal_add/model/day_goal_model_hive.dart';
import 'package:tt_18/futures/main/day_goal_add/service/day_goal_model_service.dart';
import 'package:tt_18/futures/main/day_goal_add/state/day_goal_state.dart';
import 'package:tt_18/futures/main/fitness_goals_add/logic/services/fitness_goal_model_service.dart';
import 'package:tt_18/futures/main/state/fitness_goal_state.dart';
import 'package:tt_18/futures/main/fitness_goals_add/model/fitness_goal_model_hive.dart';

class ActivityViewModel extends ChangeNotifier {
  final FitnessGoalModelService _fitnessGoalModelService =
      FitnessGoalModelService();
  final DayGoalModelService _dayGoalModelService = DayGoalModelService();
  FitnessGoalState _fitnessState = FitnessGoalState();
  DayGoalState _dayGoalState = DayGoalState();

  FitnessGoalState get fitnessState => _fitnessState;
  DayGoalState get dayGoalState => _dayGoalState;

  Future<void> loadData() async {
    await _fitnessGoalModelService.loadData();
    await _dayGoalModelService.loadData();
    await Future.delayed(const Duration(milliseconds: 500));
    _fitnessState = FitnessGoalState(
      fitnessGoalList: _fitnessGoalModelService.fitnessGoalList,
      isLoading: false,
    );
    _dayGoalState = DayGoalState(
      dayGoalList: _dayGoalModelService.dayGoalList,
      isLoading: false,
      currentDate: _dayGoalModelService.currentDateTime,
    );

    notifyListeners();
  }

  ActivityViewModel() {
    loadData();
  }

  void onDeleteFitnessGoal(FitnessGoalModelHive fitnessGoalModel) async {
    await _fitnessGoalModelService.deleteFitnessGoal(fitnessGoalModel);
    _fitnessState = FitnessGoalState(
      fitnessGoalList: _fitnessGoalModelService.fitnessGoalList,
      isLoading: false,
    );
    notifyListeners();
  }

  void onDeleteDayGoal(DayGoalModelHive dayGoalModel) async {
    await _dayGoalModelService.deleteDayGoal(dayGoalModel);
    _dayGoalState = DayGoalState(
      dayGoalList: _dayGoalModelService.dayGoalList,
      isLoading: false,
      currentDate: _dayGoalModelService.currentDateTime,
    );

    notifyListeners();
  }

  void onUpdatedFitnessGoal(FitnessGoalModelHive fitnessGoalModel) {
    _fitnessGoalModelService.editFitnessGoal(fitnessGoalModel).then((_) {
      _fitnessState = FitnessGoalState(
        fitnessGoalList: _fitnessGoalModelService.fitnessGoalList,
        isLoading: false,
      );
    });
    notifyListeners();
  }

  void onUpdatedDayGoal(DayGoalModelHive dayGoalModel) {
    _dayGoalModelService.editDayGoal(dayGoalModel).then((_) {
      _dayGoalState = DayGoalState(
        dayGoalList: _dayGoalModelService.dayGoalList,
        isLoading: false,
        currentDate: _dayGoalModelService.currentDateTime,
      );
    });
    notifyListeners();
  }

  void onUpdatedDate(DateTime date) {
    _dayGoalModelService.updateDate(date).then((_) {
      _dayGoalState = DayGoalState(
        dayGoalList: _dayGoalModelService.dayGoalList,
        currentDate: _dayGoalModelService.currentDateTime,
        isLoading: false,
      );
    });

    notifyListeners();
  }

  Future<void> onFitnessGoalItemAdded(
      FitnessGoalModelHive fitnessGoalModel) async {
    _fitnessGoalModelService.setFitnessGoal(fitnessGoalModel).then((_) {
      _fitnessState = FitnessGoalState(
        fitnessGoalList: _fitnessGoalModelService.fitnessGoalList,
        isLoading: false,
      );
      notifyListeners();
    });
  }

  Future<void> onDayGoalItemAdded(DayGoalModelHive dayGoalModel) async {
    _dayGoalModelService.setDayGoal(dayGoalModel).then((_) {
      _dayGoalState = DayGoalState(
        dayGoalList: _dayGoalModelService.dayGoalList,
        currentDate: _dayGoalModelService.currentDateTime,
        isLoading: false,
      );
      notifyListeners();
    });
  }
}
