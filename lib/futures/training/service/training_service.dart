import 'package:hive/hive.dart';
import 'package:tt_18/futures/training/model/training_hive_model.dart';

class TrainingModelService {
  List<TrainingHiveModel?> _trainingList = [];

  DateTime _dateTime = DateTime.now();

  DateTime? get currentDateTime => _dateTime;
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

  Future<void> updateDate(DateTime date) async {
    _dateTime = date;

    await loadData();
  }

  Future<void> setTraining(TrainingHiveModel dayGoalModel) async {
    final dayGoalModelBox =
        await Hive.openBox<TrainingHiveModel>('_trainingList');
    await dayGoalModelBox.add(dayGoalModel);
    _trainingList.add(dayGoalModel);
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

    await newMoaqw.save();
    await loadData();
  }
}
