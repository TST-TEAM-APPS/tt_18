import 'package:flutter/material.dart';
import 'package:tt_18/components/custom_button.dart';
import 'package:tt_18/components/custom_calendar.dart';
import 'package:tt_18/components/custom_cupertino_picker.dart';
import 'package:tt_18/components/custom_text_field.dart';
import 'package:tt_18/core/app_fonts.dart';
import 'package:tt_18/core/colors.dart';
import 'package:tt_18/futures/main/fitness_goals_add/model/fitness_goal_model.dart';

class FitnessGoalDetailScreen extends StatefulWidget {
  final FitnessGoalModel model;
  const FitnessGoalDetailScreen({super.key, required this.model});

  @override
  State<FitnessGoalDetailScreen> createState() =>
      _FitnessGoalDetailScreenState();
}

class _FitnessGoalDetailScreenState extends State<FitnessGoalDetailScreen> {
  int selectedValue = 1;
  List<DateTime?>? startedDate;
  List<DateTime?>? endedDate;
  int? currentTab;

  @override
  void initState() {
    startedDate = [
      DateTime.now(),
    ];
    endedDate = [
      DateTime.now(),
    ];
    setState(() {});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
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
                widget.model.title,
                style: AppFonts.displayLarge.copyWith(
                  color: AppColors.onBackground,
                ),
              ),
              if (widget.model.inputTitle != null)
                Column(
                  children: [
                    Text(
                      widget.model.inputTitle!,
                      style: AppFonts.displayMedium.copyWith(
                        color: AppColors.onBackground,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                        height: 35,
                        child: CustomTextField(
                          onChange: (value) {},
                        )),
                    const SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              if (widget.model.id != 4)
                Column(
                  children: [
                    Text(
                      widget.model.subtitle,
                      style: AppFonts.displayMedium.copyWith(
                        color: AppColors.onBackground,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    CustomCupertinoPicker(
                      onChange: (value) {
                        selectedValue = value;
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              Text(
                'In what time frame do you want to reach your goal?',
                style: AppFonts.displayMedium.copyWith(
                  color: AppColors.onBackground,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Expanded(
                    child: Material(
                      color: AppColors.grey,
                      borderRadius: BorderRadius.circular(20),
                      child: InkWell(
                        highlightColor: Colors.white.withOpacity(0.5),
                        borderRadius: BorderRadius.circular(20),
                        onTap: () {
                          if (currentTab == 0) {
                            currentTab = null;
                            setState(() {});
                            return;
                          }
                          currentTab = 0;
                          setState(() {});
                        },
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.transparent,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Image.asset(
                                'assets/icons/calendar.png',
                                width: 24,
                                height: 24,
                                fit: BoxFit.cover,
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              Text(
                                'Start date',
                                style: AppFonts.bodyMedium.copyWith(
                                  color: AppColors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: Material(
                      color: AppColors.grey,
                      borderRadius: BorderRadius.circular(20),
                      child: InkWell(
                        onTap: () {
                          if (currentTab == 1) {
                            currentTab = null;
                            setState(() {});
                            return;
                          }
                          currentTab = 1;
                          setState(() {});
                        },
                        highlightColor: Colors.white.withOpacity(0.5),
                        borderRadius: BorderRadius.circular(20),
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.transparent,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Image.asset(
                                'assets/icons/calendar.png',
                                width: 24,
                                height: 24,
                                fit: BoxFit.cover,
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              Text(
                                'End date',
                                style: AppFonts.bodyMedium.copyWith(
                                  color: AppColors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              if (currentTab == 0)
                CustomCalendar(
                  value: startedDate!,
                  onChangeDate: (value) {
                    startedDate = value;
                  },
                ),
              if (currentTab == 1)
                CustomCalendar(
                  value: endedDate!,
                  onChangeDate: (value) {
                    endedDate = value;
                  },
                ),
              const SizedBox(
                height: 95,
              )
            ]),
          ),
        ),
        bottomSheet: Material(
          color: Colors.transparent,
          child: Container(
              color: Colors.transparent,
              height: 95,
              padding: const EdgeInsets.only(
                  left: 20, right: 20, bottom: 25, top: 20),
              child: CustomButton(
                title: 'Save',
                borderRadius: BorderRadius.circular(20),
                highlightColor: Colors.white.withOpacity(0.5),
                titleStyle:
                    AppFonts.displayMedium.copyWith(color: AppColors.white),
                onTap: () {},
                backgroundColor: AppColors.primary,
              )),
        ),
      ),
    );
  }
}
