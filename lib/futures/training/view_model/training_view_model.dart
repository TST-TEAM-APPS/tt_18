import 'package:flutter/cupertino.dart';
import 'package:tt_18/futures/training/model/training_hive_model.dart';
import 'package:tt_18/futures/training/service/training_service.dart';
import 'package:tt_18/futures/training/state/training_state.dart';

class TrainingViewModel extends ChangeNotifier {
  final TrainingModelService _trainingModelService = TrainingModelService();

  TrainingState _trainingState = TrainingState();

  TrainingState get trainingState => _trainingState;

  Future<void> loadData() async {
    await _trainingModelService.loadData();

    _trainingState = TrainingState(
      trainingList: _trainingModelService.trainingList,
      isLoading: false,
      currentDate: _trainingModelService.currentDateTime,
    );
    print(_trainingState.trainingList.length);

    notifyListeners();
  }

  TrainingViewModel() {
    loadData();
  }

  void onDeleteTraining(TrainingHiveModel trainingModel) async {
    await _trainingModelService.deleteTraining(trainingModel);
    _trainingState = TrainingState(
      trainingList: _trainingModelService.trainingList,
      isLoading: false,
      currentDate: _trainingModelService.currentDateTime,
    );

    notifyListeners();
  }

  void onTaskComplete(TrainingHiveModel trainingModel) async {
    await _trainingModelService.taskComplete(trainingModel).then((_) {
      _trainingState = TrainingState(
        trainingList: _trainingModelService.trainingList,
        isLoading: false,
        currentDate: _trainingModelService.currentDateTime,
      );
    });
    notifyListeners();
  }

  void onUpdatedTraining(TrainingHiveModel trainingModel) {
    _trainingModelService.editTraining(trainingModel).then((_) {
      _trainingState = TrainingState(
        trainingList: _trainingModelService.trainingList,
        isLoading: false,
        currentDate: _trainingModelService.currentDateTime,
      );
    });
    notifyListeners();
  }

  void onUpdatedDate(DateTime date) {
    _trainingModelService.updateDate(date).then((_) {
      _trainingState = TrainingState(
        trainingList: _trainingModelService.trainingList,
        currentDate: _trainingModelService.currentDateTime,
        isLoading: false,
      );
    });

    notifyListeners();
  }

  Future<void> onTrainingItemAdded(TrainingHiveModel trainingModel) async {
    _trainingModelService.setTraining(trainingModel).then((_) {
      _trainingState = TrainingState(
        trainingList: _trainingModelService.trainingList,
        currentDate: _trainingModelService.currentDateTime,
        isLoading: false,
      );
      notifyListeners();
    });
  }
}
