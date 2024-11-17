class FitnessGoalModel {
  final int id;
  final String title;
  final String subtitle;
  final String imagePath;
  final String? inputTitle;
  final String? format;

  FitnessGoalModel({
    this.inputTitle,
    required this.id,
    required this.title,
    required this.subtitle,
    required this.imagePath,
    required this.format,
  });
}
