// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:hive/hive.dart';

part 'fitness_goal_model_hive.g.dart';

@HiveType(typeId: 3)
class FitnessGoalModelHive extends HiveObject {
  @HiveField(0)
  final int id;
  @HiveField(1)
  final String imagePath;
  @HiveField(2)
  final String name;
  @HiveField(3)
  final DateTime startedDate;
  @HiveField(4)
  final DateTime endedDate;
  @HiveField(5)
  int? currentProgress;
  @HiveField(6)
  int? goal;
  @HiveField(7)
  String? description;

  FitnessGoalModelHive(
      {int? id,
      required this.imagePath,
      required this.name,
      required this.startedDate,
      required this.endedDate,
      this.currentProgress,
      this.goal,
      this.description})
      : id = id ?? DateTime.now().microsecondsSinceEpoch;

  FitnessGoalModelHive copyWith({
    int? id,
    String? imagePath,
    String? name,
    DateTime? startedDate,
    DateTime? endedDate,
    int? currentProgress,
    int? goal,
    String? description,
  }) {
    return FitnessGoalModelHive(
      id: this.id,
      imagePath: imagePath ?? this.imagePath,
      name: name ?? this.name,
      startedDate: startedDate ?? this.startedDate,
      endedDate: endedDate ?? this.endedDate,
      currentProgress: currentProgress ?? this.currentProgress,
      goal: goal ?? this.goal,
      description: description ?? this.description,
    );
  }
}
