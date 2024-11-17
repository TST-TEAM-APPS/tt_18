import 'package:hive/hive.dart';
import 'package:tt_18/futures/main/day_goal_add/model/day_goal_model_hive.dart';

class DayGoalModelService {
  List<DayGoalModelHive?> _dayGoalList = [];

  DateTime _dateTime = DateTime.now();
  List<String> _tags = [];

  DateTime? get currentDateTime => _dateTime;
  List<DayGoalModelHive?> get dayGoalList => _dayGoalList;

  Future<void> loadData() async {
    final dayModelBox = await Hive.openBox<DayGoalModelHive>('_dayGoalList');
    if (_tags.isEmpty) {
      _dayGoalList = dayModelBox.values.toList();
      if (_dayGoalList.isNotEmpty) {
        _dayGoalList = _dayGoalList.where((element) {
          return element!.reireration.contains(_dateTime.weekday);
        }).toList();
        return;
      }
      return;
    }
    _dayGoalList = dayModelBox.values.where((element) {
      return _tags.contains(element.tag);
    }).toList();
  }

  Future<void> updateDate(DateTime date) async {
    _dateTime = date;

    await loadData();
  }

  bool _isEqual(DayGoalModelHive trainingHiveModel, DateTime dateTime) {
    bool? isTrue;
    for (var date in trainingHiveModel.isDone) {
      if (date.year == dateTime.year &&
          date.month == dateTime.month &&
          date.day == dateTime.day) {
        isTrue = true;
      }
    }
    return isTrue ?? false;
  }

  Future<void> taskComplete(DayGoalModelHive trainingModel) async {
    final foodModelBox = await Hive.openBox<DayGoalModelHive>('_dayGoalList');
    DayGoalModelHive newMoaqw =
        foodModelBox.values.singleWhere((e) => e.id == trainingModel.id);
    List<DateTime> completedDates;
    if (_isEqual(trainingModel, _dateTime)) {
      completedDates = List<DateTime>.from(trainingModel.isDone);
      completedDates.removeWhere((e) {
        return e.day == _dateTime.day &&
            e.month == _dateTime.month &&
            e.year == _dateTime.year;
      });
    } else {
      completedDates = List<DateTime>.from(trainingModel.isDone);
      completedDates.add(_dateTime);
    }

    newMoaqw.name = trainingModel.name;
    newMoaqw.description = trainingModel.description;
    newMoaqw.isDone = completedDates;
    newMoaqw.reireration = trainingModel.reireration;

    newMoaqw.tag = trainingModel.tag;
    await newMoaqw.save();
    await loadData();
  }

  Future<void> setDayGoal(DayGoalModelHive dayGoalModel) async {
    final dayGoalModelBox =
        await Hive.openBox<DayGoalModelHive>('_dayGoalList');
    await dayGoalModelBox.add(dayGoalModel);
    _dayGoalList.add(dayGoalModel);
    await loadData();
  }

  Future<void> deleteDayGoal(DayGoalModelHive dayGoalModel) async {
    final employeList = await Hive.openBox<DayGoalModelHive>('_dayGoalList');
    final element =
        employeList.values.toList().singleWhere((e) => e.id == dayGoalModel.id);
    await element.delete();
    await employeList.compact();
    await loadData();
  }

  Future<void> editDayGoal(DayGoalModelHive dayGoalEditModel) async {
    final foodModelBox = await Hive.openBox<DayGoalModelHive>('_dayGoalList');
    DayGoalModelHive newMoaqw =
        foodModelBox.values.singleWhere((e) => e.id == dayGoalEditModel.id);

    newMoaqw.name = dayGoalEditModel.name;
    newMoaqw.description = dayGoalEditModel.description;
    newMoaqw.isDone = dayGoalEditModel.isDone;
    newMoaqw.reireration = dayGoalEditModel.reireration;
    newMoaqw.tag = newMoaqw.tag;

    await newMoaqw.save();
    await loadData();
  }
}
