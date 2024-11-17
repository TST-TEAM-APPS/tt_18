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
