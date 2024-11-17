// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:hive/hive.dart';

part 'day_goal_model_hive.g.dart';

@HiveType(typeId: 4)
class DayGoalModelHive extends HiveObject {
  @HiveField(0)
  int id;
  @HiveField(1)
  String name;
  @HiveField(2)
  String description;
  @HiveField(3)
  List<int> reireration;
  @HiveField(4)
  String tag;
  @HiveField(5)
  List<DateTime> isDone;

  DayGoalModelHive(
      {int? id,
      required this.name,
      required this.description,
      required this.isDone,
      required this.reireration,
      required this.tag})
      : id = id ?? DateTime.now().microsecondsSinceEpoch;
}
