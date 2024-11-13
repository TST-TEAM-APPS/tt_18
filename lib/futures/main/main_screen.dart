import 'package:flutter/material.dart';
import 'package:tt_18/components/custom_button.dart';
import 'package:tt_18/components/custom_current_date_widget.dart';
import 'package:tt_18/core/app_fonts.dart';
import 'package:tt_18/core/colors.dart';
import 'package:tt_18/futures/main/fitness_goals_add/fitness_goals_add_screen.dart';
import 'package:tt_18/futures/main/fitness_goals_add/model/fitness_goal_model.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const CurrentDateWIdget(),
                const SizedBox(
                  height: 35,
                ),
                const _ActivityLabel(),
                const SizedBox(
                  height: 15,
                ),
                const _ProgressWidget(),
                const SizedBox(
                  height: 23,
                ),
                _NothingWidget(
                  title: 'Fitness goals',
                  imagePath: 'assets/images/target.png',
                  text: 'No long-term goals',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const FitnessGoalsAddScreen()),
                    );
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                _NothingWidget(
                  title: 'Goals for the day',
                  imagePath: 'assets/images/target2.png',
                  text: 'There are no goals for today',
                  onTap: () {},
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _NothingWidget extends StatelessWidget {
  final String title;
  final String imagePath;
  final String text;
  final Function onTap;
  const _NothingWidget({
    required this.title,
    required this.imagePath,
    required this.text,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: AppFonts.displayMedium.copyWith(color: AppColors.onBackground),
        ),
        Container(
          padding: const EdgeInsets.all(10),
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: AppColors.primary,
          ),
          child: Column(
            children: [
              Image.asset(imagePath),
              const SizedBox(
                height: 5,
              ),
              Text(
                text,
                style:
                    AppFonts.displaySmall.copyWith(color: AppColors.onSurface),
              ),
              const SizedBox(
                height: 5,
              ),
              Material(
                color: AppColors.surface,
                borderRadius: BorderRadius.circular(20),
                child: InkWell(
                  highlightColor: Colors.white.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(20),
                  onTap: () {
                    onTap();
                  },
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.transparent,
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'Add',
                          style: AppFonts.displaySmall
                              .copyWith(color: AppColors.onSurface),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Image.asset(
                          'assets/icons/plus.png',
                          width: 24,
                          height: 24,
                          fit: BoxFit.cover,
                        )
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}

class _ProgressWidget extends StatelessWidget {
  const _ProgressWidget();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Your progress',
          style: AppFonts.displayMedium.copyWith(color: AppColors.onBackground),
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          children: [
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: AppColors.primary,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        'Calories',
                        style: AppFonts.displaySmall
                            .copyWith(color: AppColors.onPrimary),
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: '0',
                            style: AppFonts.displayLarge
                                .copyWith(color: AppColors.onPrimary),
                          ),
                          TextSpan(
                            text: '/0',
                            style: AppFonts.displaySmall
                                .copyWith(color: AppColors.onPrimary),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: AppColors.surface,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        'Activity time',
                        style: AppFonts.displaySmall
                            .copyWith(color: AppColors.onPrimary),
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: '0',
                            style: AppFonts.displayLarge
                                .copyWith(color: AppColors.onPrimary),
                          ),
                          const WidgetSpan(
                            child: SizedBox(width: 2),
                          ),
                          TextSpan(
                            text: 'H',
                            style: AppFonts.displaySmall
                                .copyWith(color: AppColors.onPrimary),
                          ),
                          const WidgetSpan(
                            child: SizedBox(width: 10),
                          ),
                          TextSpan(
                            text: '0',
                            style: AppFonts.displayMedium
                                .copyWith(color: AppColors.onPrimary),
                          ),
                          const WidgetSpan(
                            child: SizedBox(width: 2),
                          ),
                          TextSpan(
                            text: 'Min',
                            style: AppFonts.displaySmall
                                .copyWith(color: AppColors.onPrimary),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        )
      ],
    );
  }
}

class _ActivityLabel extends StatelessWidget {
  const _ActivityLabel();

  @override
  Widget build(BuildContext context) {
    return Text(
      'Activity',
      style: AppFonts.displayLarge.copyWith(color: AppColors.onBackground),
    );
  }
}
