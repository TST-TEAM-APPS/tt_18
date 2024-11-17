import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tt_18/components/custom_button.dart';
import 'package:tt_18/core/app_fonts.dart';
import 'package:tt_18/core/colors.dart';
import 'package:tt_18/futures/training/model/training_hive_model.dart';

class TrainingDetailsFirstScreen extends StatefulWidget {
  final PageController pageController;
  final int? selectedCardId;
  final Function onNext;
  const TrainingDetailsFirstScreen(
      {super.key,
      required this.pageController,
      required this.onNext,
      this.selectedCardId});

  @override
  State<TrainingDetailsFirstScreen> createState() =>
      _TrainingDetailsFirstScreenState();
}

class _TrainingDetailsFirstScreenState
    extends State<TrainingDetailsFirstScreen> {
  List<TrainingType> trainiTypeList = [
    TrainingType(
        id: 0,
        name: 'Cardio training',
        imagePath: 'assets/icons/Cardiotraining.png'),
    TrainingType(
        id: 1,
        name: 'Strength training',
        imagePath: 'assets/icons/Strengthtraining.png'),
    TrainingType(
        id: 2, name: 'Flexibility', imagePath: 'assets/icons/Flexibility.png'),
    TrainingType(
        id: 3,
        name: 'Interval training',
        imagePath: 'assets/icons/Intervaltraining.png'),
    TrainingType(
        id: 4,
        name: 'Martial arts ',
        imagePath: 'assets/icons/Martialarts.png'),
    TrainingType(
        id: 5, name: 'Team sports', imagePath: 'assets/icons/Teamsports.png'),
    TrainingType(
        id: 6,
        name: 'Individual sports',
        imagePath: 'assets/icons/Individualsports.png'),
    TrainingType(
        id: 7,
        name: 'Outdoors activities',
        imagePath: 'assets/icons/Outdoorsactivities.png'),
  ];

  int? selectedCard;

  @override
  void initState() {
    if (widget.selectedCardId != null) {
      selectedCard = widget.selectedCardId!;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Select the type of training',
          style: AppFonts.displayMedium.copyWith(
            color: AppColors.onBackground,
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 10,
            mainAxisSpacing: 15,
            childAspectRatio: 1 / 1.5,
          ),
          itemCount: trainiTypeList.length,
          itemBuilder: (BuildContext context, int index) {
            return Material(
              color: selectedCard == index ? AppColors.surface : AppColors.grey,
              borderRadius: BorderRadius.circular(20),
              child: InkWell(
                onTap: () {
                  selectedCard = index;
                  setState(() {});
                },
                borderRadius: BorderRadius.circular(20),
                highlightColor: Colors.white.withOpacity(0.5),
                child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    children: [
                      Image.asset(
                        trainiTypeList[index].imagePath,
                        height: 85,
                        width: 85,
                        fit: BoxFit.cover,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        trainiTypeList[index].name,
                        maxLines: 2,
                        textAlign: TextAlign.center,
                        style: AppFonts.displaySmall.copyWith(
                          color: AppColors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
        const SizedBox(
          height: 10,
        ),
        CustomButton(
          onTap: () async {
            await widget.onNext(trainiTypeList[selectedCard!]);

            widget.pageController.nextPage(
                duration: const Duration(microseconds: 500),
                curve: Curves.easeInOut);
          },
          title: 'Save',
          backgroundColor: AppColors.primary,
          isValid: selectedCard != null,
          borderRadius: BorderRadius.circular(20),
          highlightColor: Colors.white.withOpacity(0.5),
          titleStyle: AppFonts.displayMedium.copyWith(color: AppColors.white),
        )
      ],
    );
  }
}
