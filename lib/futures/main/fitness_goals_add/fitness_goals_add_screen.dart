import 'package:flutter/material.dart';
import 'package:tt_18/core/app_fonts.dart';
import 'package:tt_18/core/colors.dart';
import 'package:tt_18/futures/main/fitness_goals_add/fitness_goal_detail/fitness_goal_detail_screen.dart';
import 'package:tt_18/futures/main/fitness_goals_add/model/fitness_goal_model.dart';

class FitnessGoalsAddScreen extends StatefulWidget {
  const FitnessGoalsAddScreen({super.key});

  @override
  State<FitnessGoalsAddScreen> createState() => _FitnessGoalsAddScreenState();
}

class _FitnessGoalsAddScreenState extends State<FitnessGoalsAddScreen> {
  List<FitnessGoalModel> fitnessGoalModelList = [
    FitnessGoalModel(
      id: 0,
      title: 'Losing weight',
      subtitle: 'How many kg do you want to lose?',
      imagePath: 'assets/icons/loosing-weight.png',
    ),
    FitnessGoalModel(
      id: 1,
      title: 'Muscle mass gain',
      subtitle:
          'How many kilograms do you want to increase your muscle mass by?',
      imagePath: 'assets/icons/muscle-mass.png',
    ),
    FitnessGoalModel(
      id: 2,
      title: 'Increased strength',
      subtitle: 'What exercise do you want to improve?',
      imagePath: 'assets/icons/increased-strength.png',
      inputTitle: 'What exercise do you want to improve?',
    ),
    FitnessGoalModel(
      id: 3,
      title: 'Improved endurance',
      subtitle: 'What distance do you want to run/ride? (Km)',
      imagePath: 'assets/icons/improved-endurance.png',
    ),
    FitnessGoalModel(
      id: 4,
      title: 'Improved flexibility',
      subtitle: 'What area of flexibility do you want to improve?',
      imagePath: 'assets/icons/improved-flexibility.png',
      inputTitle: 'What area of flexibility do you want to improve?',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Image.asset(
                  'assets/icons/back.png',
                  width: 34,
                  height: 34,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                'What is the goal you want to achieve?',
                style: AppFonts.displayMedium.copyWith(
                  color: AppColors.onBackground,
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (BuildContext context, int index) {
                    return _FitnessGoalsAddItemWidget(
                      title: fitnessGoalModelList[index].title,
                      imagePath: fitnessGoalModelList[index].imagePath,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => FitnessGoalDetailScreen(
                                model: fitnessGoalModelList[index]),
                          ),
                        );
                      },
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) {
                    return const SizedBox(
                      height: 10,
                    );
                  },
                  itemCount: fitnessGoalModelList.length),
            ],
          ),
        ),
      ),
    ));
  }
}

class _FitnessGoalsAddItemWidget extends StatelessWidget {
  final Function onTap;
  final String title;
  final String imagePath;
  const _FitnessGoalsAddItemWidget({
    required this.onTap,
    required this.title,
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.grey,
      borderRadius: BorderRadius.circular(20),
      child: InkWell(
        highlightColor: Colors.white.withOpacity(0.7),
        borderRadius: BorderRadius.circular(20),
        onTap: () {
          onTap();
        },
        child: Container(
          padding: const EdgeInsets.all(10),
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.transparent,
          ),
          child: Row(children: [
            Image.asset(
              imagePath,
              width: 48,
              height: 48,
              fit: BoxFit.cover,
            ),
            const SizedBox(
              width: 10,
            ),
            Text(
              title,
              style: AppFonts.bodyLarge.copyWith(
                color: AppColors.white,
              ),
            )
          ]),
        ),
      ),
    );
  }
}
