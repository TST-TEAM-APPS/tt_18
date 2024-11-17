import 'package:hive/hive.dart';
import 'package:tt_18/futures/training/model/training_hive_model.dart';

class TrainingModelService {
  List<TrainingHiveModel?> _trainingList = [];

  DateTime _dateTime = DateTime.now();
  int _activityTime = 0;

  DateTime? get currentDateTime => _dateTime;
  int get activityTime => _activityTime;
  List<TrainingHiveModel?> get trainingList => _trainingList;

  Future<void> loadData() async {
    final dayModelBox = await Hive.openBox<TrainingHiveModel>('_trainingList');
    _trainingList = dayModelBox.values.toList();
    if (_trainingList.isNotEmpty) {
      _trainingList = _trainingList.where((element) {
        return element!.reireration.contains(_dateTime.weekday);
      }).toList();
      return;
    }
  }

  bool _isEqual(TrainingHiveModel trainingHiveModel, DateTime dateTime) {
    bool? isTrue;
    for (var date in trainingHiveModel.completedDates) {
      if (date.year == dateTime.year &&
          date.month == dateTime.month &&
          date.day == dateTime.day) {
        isTrue = true;
      }
    }
    return isTrue ?? false;
  }

  Future<void> updateDate(DateTime date) async {
    _dateTime = date;

    await loadData();
  }

  Future<void> getActivityTime(DateTime date) async {
    final matchingActivities = <TrainingHiveModel>[];

    for (var e in _trainingList) {
      if (e != null) {
        for (var completedDate in e.completedDates) {
          if (completedDate.year == date.year &&
              completedDate.month == date.month &&
              completedDate.day == date.day) {
            matchingActivities.add(e);
          }
        }
      } else {
        break;
      }
    }
    for (var e in matchingActivities) {
      _activityTime +=
          (e.numberOfRep * e.restTime + e.workingTime * e.numberOfRep);
    }
  }

  Future<void> taskComplete(TrainingHiveModel trainingModel) async {
    final foodModelBox = await Hive.openBox<TrainingHiveModel>('_trainingList');
    TrainingHiveModel newMoaqw =
        foodModelBox.values.singleWhere((e) => e.id == trainingModel.id);
    if (_isEqual(trainingModel, _dateTime)) {
      return;
    }
    List<DateTime> completedDates =
        List<DateTime>.from(trainingModel.completedDates);

    completedDates.add(_dateTime);
    newMoaqw.name = trainingModel.name;
    newMoaqw.description = trainingModel.description;
    newMoaqw.numberOfRep = trainingModel.numberOfRep;
    newMoaqw.restTime = trainingModel.restTime;
    newMoaqw.trainingType = trainingModel.trainingType;
    newMoaqw.workingTime = trainingModel.workingTime;
    newMoaqw.reireration = trainingModel.reireration;
    newMoaqw.completedDates = completedDates;
    await newMoaqw.save();
    await loadData();
  }

  Future<void> setTraining(TrainingHiveModel dayGoalModel) async {
    final dayGoalModelBox =
        await Hive.openBox<TrainingHiveModel>('_trainingList');
    await dayGoalModelBox.add(dayGoalModel);

    await loadData();
  }

  Future<void> deleteTraining(TrainingHiveModel dayGoalModel) async {
    final employeList = await Hive.openBox<TrainingHiveModel>('_trainingList');
    final element =
        employeList.values.toList().singleWhere((e) => e.id == dayGoalModel.id);
    await element.delete();
    await employeList.compact();
    await loadData();
  }

  Future<void> editTraining(TrainingHiveModel dayGoalEditModel) async {
    final foodModelBox = await Hive.openBox<TrainingHiveModel>('_trainingList');
    TrainingHiveModel newMoaqw =
        foodModelBox.values.singleWhere((e) => e.id == dayGoalEditModel.id);

    newMoaqw.name = dayGoalEditModel.name;
    newMoaqw.description = dayGoalEditModel.description;
    newMoaqw.numberOfRep = dayGoalEditModel.numberOfRep;
    newMoaqw.restTime = dayGoalEditModel.restTime;
    newMoaqw.trainingType = dayGoalEditModel.trainingType;
    newMoaqw.workingTime = dayGoalEditModel.workingTime;
    newMoaqw.reireration = dayGoalEditModel.reireration;
    newMoaqw.completedDates = dayGoalEditModel.completedDates;

    await newMoaqw.save();
    await loadData();
  }
}
