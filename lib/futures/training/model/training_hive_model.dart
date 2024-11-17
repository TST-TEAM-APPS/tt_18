// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:hive/hive.dart';

part 'training_hive_model.g.dart';

@HiveType(typeId: 5)
class TrainingHiveModel extends HiveObject {
  @HiveField(0)
  int id;
  @HiveField(1)
  String name;
  @HiveField(2)
  String description;
  @HiveField(3)
  List<int> reireration;
  @HiveField(4)
  int workingTime;
  @HiveField(5)
  int restTime;
  @HiveField(6)
  int numberOfRep;
  @HiveField(7)
  TrainingType trainingType;

  TrainingHiveModel({
    int? id,
    required this.name,
    required this.description,
    required this.reireration,
    required this.numberOfRep,
    required this.restTime,
    required this.workingTime,
    required this.trainingType,
  }) : id = id ?? DateTime.now().microsecondsSinceEpoch;
}

@HiveType(typeId: 6)
class TrainingType {
  @HiveField(0)
  int id;
  @HiveField(1)
  String name;
  @HiveField(2)
  String imagePath;

  TrainingType({required this.id, required this.name, required this.imagePath});
}
