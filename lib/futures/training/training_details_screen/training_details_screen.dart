import 'package:flutter/material.dart';

import 'package:tt_18/core/app_fonts.dart';
import 'package:tt_18/core/colors.dart';
import 'package:tt_18/futures/training/model/training_hive_model.dart';
import 'package:tt_18/futures/training/training_details_screen/widgets/training_details_first_screen.dart';
import 'package:tt_18/futures/training/training_details_screen/widgets/training_details_second_screen.dart';
import 'package:tt_18/futures/training/training_details_screen/widgets/training_details_third_screen.dart';
import 'package:tt_18/futures/training/view_model/training_view_model.dart';

class TrainingDetailsScreen extends StatefulWidget {
  final TrainingViewModel model;
  final TrainingHiveModel? trainingHiveModel;
  const TrainingDetailsScreen(
      {super.key, required this.model, this.trainingHiveModel});

  @override
  State<TrainingDetailsScreen> createState() => _TrainingDetailsScreenState();
}

class _TrainingDetailsScreenState extends State<TrainingDetailsScreen> {
  late PageController _pageController;
  int? selectedCard;
  String? name;
  String? description;
  List<int> reiteration = [];
  int? workingTime;
  int? restTime;
  int? numberOfPreps;

  @override
  void initState() {
    _pageController = PageController();
    if (widget.trainingHiveModel != null) {
      selectedCard = widget.trainingHiveModel!.trainingType.id;
      name = widget.trainingHiveModel!.name;
      description = widget.trainingHiveModel!.description;
      workingTime = widget.trainingHiveModel!.workingTime;
      restTime = widget.trainingHiveModel!.restTime;
      numberOfPreps = widget.trainingHiveModel!.numberOfRep;
      reiteration = widget.trainingHiveModel!.reireration;
    }
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  TrainingType? trainingType;

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
                  'Add training',
                  style: AppFonts.displayLarge.copyWith(
                    color: AppColors.onBackground,
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                SizedBox(
                  height: 660,
                  child: PageView(
                    controller: _pageController,
                    physics: const NeverScrollableScrollPhysics(),
                    children: [
                      TrainingDetailsFirstScreen(
                        pageController: _pageController,
                        selectedCardId: selectedCard,
                        onNext: (value) {
                          trainingType = value;
                        },
                      ),
                      TrainingDetailsSeconsScreen(
                          name: name,
                          description: description,
                          selectedDays: reiteration,
                          pageController: _pageController,
                          onNext:
                              (nameValue, descriptionValue, reiterationValue) {
                            name = nameValue;
                            description = descriptionValue;
                            reiteration = reiterationValue;
                          }),
                      TrainingDetailsThirdScreen(
                        preps: numberOfPreps,
                        restTime: restTime,
                        workingTime: workingTime,
                        pageController: _pageController,
                        onNext: (workingTimeValue, restTimeValue,
                            numberOfPrepsValue) async {
                          workingTime = workingTimeValue;
                          restTime = restTimeValue;
                          numberOfPreps = numberOfPrepsValue;
                          if (widget.trainingHiveModel != null) {
                            widget.model.onUpdatedTraining(TrainingHiveModel(
                                id: widget.trainingHiveModel!.id,
                                name: name!,
                                description: description!,
                                reireration: reiteration,
                                numberOfRep: numberOfPreps!,
                                restTime: restTime!,
                                workingTime: workingTime!,
                                completedDates:
                                    widget.trainingHiveModel!.completedDates,
                                trainingType: trainingType!));
                            Navigator.pop(context);
                            return;
                          }

                          await widget.model.onTrainingItemAdded(
                              TrainingHiveModel(
                                  name: name!,
                                  description: description!,
                                  reireration: reiteration,
                                  numberOfRep: numberOfPreps!,
                                  restTime: restTime!,
                                  workingTime: workingTime!,
                                  trainingType: trainingType!));
                          Navigator.pop(context);
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
