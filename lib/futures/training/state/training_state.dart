import 'package:tt_18/futures/training/model/training_hive_model.dart';

class TrainingState {
  List<TrainingHiveModel?> trainingList;
  bool isLoading;
  DateTime? currentDate;

  TrainingState({
    this.trainingList = const [],
    this.isLoading = true,
    this.currentDate,
  });
}
