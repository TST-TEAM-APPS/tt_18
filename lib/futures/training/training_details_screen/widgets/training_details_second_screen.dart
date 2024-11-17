import 'package:flutter/material.dart';
import 'package:tt_18/components/custom_button.dart';
import 'package:tt_18/components/custom_text_field.dart';
import 'package:tt_18/core/app_fonts.dart';
import 'package:tt_18/core/colors.dart';

class TrainingDetailsSeconsScreen extends StatefulWidget {
  final PageController pageController;
  final String? name;
  final String? description;
  final List<int>? selectedDays;
  final Function onNext;
  const TrainingDetailsSeconsScreen(
      {super.key,
      required this.pageController,
      required this.onNext,
      this.name,
      this.description,
      this.selectedDays});

  @override
  State<TrainingDetailsSeconsScreen> createState() =>
      _TrainingDetailsSeconsScreenState();
}

class _TrainingDetailsSeconsScreenState
    extends State<TrainingDetailsSeconsScreen> {
  String? name;
  String? description;
  List<int> selectedDays = [];

  String _getDayAbbreviation(int weekday) {
    const dayAbbreviations = ["M", "T", "W", "T", "F", "S", "S"];
    return dayAbbreviations[weekday - 1];
  }

  @override
  void initState() {
    if (widget.name != null) {
      name = widget.name;
    }
    if (widget.description != null) {
      description = widget.description;
    }
    if (widget.selectedDays != null) {
      if (widget.selectedDays!.isNotEmpty) {
        selectedDays = widget.selectedDays!;
      }
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Goal name',
          style: AppFonts.displayMedium.copyWith(
            color: AppColors.onBackground,
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        SizedBox(
            height: 35,
            child: CustomTextField(
              hintText: 'Goal name',
              initialValue: name,
              onChange: (value) {
                name = value;
                setState(() {});
              },
            )),
        const SizedBox(
          height: 30,
        ),
        Text(
          'Description',
          style: AppFonts.displayMedium.copyWith(
            color: AppColors.onBackground,
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        SizedBox(
            height: 35,
            child: CustomTextField(
              hintText: 'Description',
              initialValue: description,
              onChange: (value) {
                description = value;
                setState(() {});
              },
            )),
        const SizedBox(
          height: 30,
        ),
        Text(
          'Goal reiteration',
          style: AppFonts.displayMedium.copyWith(
            color: AppColors.onBackground,
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        SizedBox(
          height: 36,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(7, (index) {
              int day = index + 1;
              bool isSelected = selectedDays.contains(day);
              return GestureDetector(
                onTap: () {
                  setState(() {
                    if (isSelected) {
                      selectedDays.remove(day);
                    } else {
                      selectedDays.add(day);
                    }
                  });
                },
                child: Container(
                  width: 36,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: isSelected ? AppColors.primary : AppColors.grey),
                  child: Center(
                    child: Text(
                      _getDayAbbreviation(day),
                      style: const TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  ),
                ),
              );
            }),
          ),
        ),
        const SizedBox(
          height: 50,
        ),
        CustomButton(
          onTap: () async {
            await widget.onNext(name, description, selectedDays);
            widget.pageController.nextPage(
                duration: const Duration(microseconds: 500),
                curve: Curves.easeInOut);
          },
          title: 'Save',
          backgroundColor: AppColors.primary,
          isValid:
              selectedDays.isNotEmpty && name != null && description != null,
          borderRadius: BorderRadius.circular(20),
          highlightColor: Colors.white.withOpacity(0.5),
          titleStyle: AppFonts.displayMedium.copyWith(color: AppColors.white),
        )
      ],
    );
  }
}
