import 'package:flutter/material.dart';
import 'package:tt_18/components/custom_button.dart';
import 'package:tt_18/components/custom_text_field.dart';
import 'package:tt_18/core/app_fonts.dart';
import 'package:tt_18/core/colors.dart';
import 'package:tt_18/futures/main/day_goal_add/model/day_goal_model_hive.dart';
import 'package:tt_18/futures/main/view_model/activity_view_model.dart';

class DayGoalAddingScreen extends StatefulWidget {
  final ActivityViewModel model;
  final DayGoalModelHive? dayGoalModel;
  const DayGoalAddingScreen({
    super.key,
    required this.model,
    this.dayGoalModel,
  });

  @override
  State<DayGoalAddingScreen> createState() => _DayGoalAddingScreenState();
}

class _DayGoalAddingScreenState extends State<DayGoalAddingScreen> {
  List<int> selectedDays = [];
  String? name;
  String? description;
  String? _selectedTag;

  bool isTodayInReiteration() {
    int today = DateTime.now().weekday;
    return selectedDays.contains(today);
  }

  String _getDayAbbreviation(int weekday) {
    const dayAbbreviations = ["M", "T", "W", "T", "F", "S", "S"];
    return dayAbbreviations[weekday - 1];
  }

  @override
  void initState() {
    if (widget.dayGoalModel != null) {
      selectedDays = widget.dayGoalModel!.reireration;
      name = widget.dayGoalModel!.name;
      description = widget.dayGoalModel!.description;
      _selectedTag = widget.dayGoalModel!.tag;
    }
    super.initState();
  }

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
                  'Goal for the day',
                  style: AppFonts.displayLarge.copyWith(
                    color: AppColors.onBackground,
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
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
                              color: isSelected
                                  ? AppColors.primary
                                  : AppColors.grey),
                          child: Center(
                            child: Text(
                              _getDayAbbreviation(day),
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 20),
                            ),
                          ),
                        ),
                      );
                    }),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Wrap(
                  spacing: 8.0,
                  children: [
                    ChoiceChip(
                      side: BorderSide(
                        width: 1,
                        color: _selectedTag == 'Losing weight'
                            ? AppColors.primary
                            : AppColors.background,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20), // Радиус углов
                      ),
                      backgroundColor: AppColors.darkGrey,
                      label: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Image.asset(
                            'assets/icons/loosing-weight.png',
                            height: 24,
                            width: 24,
                            fit: BoxFit.cover,
                          ),
                          Text(
                            'Losing weight',
                            style: AppFonts.bodySmall.copyWith(
                              color: AppColors.white,
                            ),
                          ),
                        ],
                      ),
                      showCheckmark: false,
                      selectedColor: AppColors.grey,
                      selected: _selectedTag == 'Losing weight',
                      onSelected: (selected) {
                        setState(() {
                          _selectedTag = selected ? 'Losing weight' : null;
                        });
                      },
                    ),
                    ChoiceChip(
                      side: BorderSide(
                        width: 1,
                        color: _selectedTag == 'Muscle mass gain'
                            ? AppColors.primary
                            : AppColors.background,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20), // Радиус углов
                      ),
                      backgroundColor: AppColors.darkGrey,
                      label: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Image.asset(
                            'assets/icons/muscle-mass.png',
                            height: 24,
                            width: 24,
                            fit: BoxFit.cover,
                          ),
                          Text(
                            'Muscle mass gain',
                            style: AppFonts.bodySmall.copyWith(
                              color: AppColors.white,
                            ),
                          ),
                        ],
                      ),
                      showCheckmark: false,
                      selectedColor: AppColors.grey,
                      selected: _selectedTag == 'Muscle mass gain',
                      onSelected: (selected) {
                        setState(() {
                          _selectedTag = selected ? 'Muscle mass gain' : null;
                        });
                      },
                    ),
                    ChoiceChip(
                      side: BorderSide(
                        width: 1,
                        color: _selectedTag == 'Increased strength'
                            ? AppColors.primary
                            : AppColors.background,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20), // Радиус углов
                      ),
                      backgroundColor: AppColors.darkGrey,
                      label: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Image.asset(
                            'assets/icons/increased-strength.png',
                            height: 24,
                            width: 24,
                            fit: BoxFit.cover,
                          ),
                          Text(
                            'Increased strength',
                            style: AppFonts.bodySmall.copyWith(
                              color: AppColors.white,
                            ),
                          ),
                        ],
                      ),
                      showCheckmark: false,
                      selectedColor: AppColors.grey,
                      selected: _selectedTag == 'Increased strength',
                      onSelected: (selected) {
                        setState(() {
                          _selectedTag = selected ? 'Increased strength' : null;
                        });
                      },
                    ),
                    ChoiceChip(
                      side: BorderSide(
                        width: 1,
                        color: _selectedTag == 'Improved endurance'
                            ? AppColors.primary
                            : AppColors.background,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20), // Радиус углов
                      ),
                      backgroundColor: AppColors.darkGrey,
                      label: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Image.asset(
                            'assets/icons/improved-endurance.png',
                            height: 24,
                            width: 24,
                            fit: BoxFit.cover,
                          ),
                          Text(
                            'Improved endurance',
                            style: AppFonts.bodySmall.copyWith(
                              color: AppColors.white,
                            ),
                          ),
                        ],
                      ),
                      showCheckmark: false,
                      selectedColor: AppColors.grey,
                      selected: _selectedTag == 'Improved endurance',
                      onSelected: (selected) {
                        setState(() {
                          _selectedTag = selected ? 'Improved endurance' : null;
                        });
                      },
                    ),
                    ChoiceChip(
                      side: BorderSide(
                        width: 1,
                        color: _selectedTag == 'Improved flexibility'
                            ? AppColors.primary
                            : AppColors.background,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20), // Радиус углов
                      ),
                      backgroundColor: AppColors.darkGrey,
                      label: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Image.asset(
                            'assets/icons/improved-flexibility.png',
                            height: 24,
                            width: 24,
                            fit: BoxFit.cover,
                          ),
                          Text(
                            'Improved flexibility',
                            style: AppFonts.bodySmall.copyWith(
                              color: AppColors.white,
                            ),
                          ),
                        ],
                      ),
                      showCheckmark: false,
                      selectedColor: AppColors.grey,
                      selected: _selectedTag == 'Improved flexibility',
                      onSelected: (selected) {
                        setState(() {
                          _selectedTag =
                              selected ? 'Improved flexibility' : null;
                        });
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        bottomSheet: Material(
          color: Colors.transparent,
          child: Container(
              color: Colors.transparent,
              height: 95,
              padding: const EdgeInsets.only(
                  left: 20, right: 20, bottom: 20, top: 20),
              child: CustomButton(
                title: 'Save',
                borderRadius: BorderRadius.circular(20),
                highlightColor: Colors.white.withOpacity(0.5),
                titleStyle:
                    AppFonts.displayMedium.copyWith(color: AppColors.white),
                onTap: () {
                  if (widget.dayGoalModel != null) {
                    widget.model.onUpdatedDayGoal(DayGoalModelHive(
                        id: widget.dayGoalModel!.id,
                        name: name!,
                        description: description!,
                        isDone: widget.dayGoalModel!.isDone,
                        reireration: selectedDays,
                        tag: _selectedTag!));
                    Navigator.pop(context);
                    return;
                  }
                  widget.model.onDayGoalItemAdded(
                    DayGoalModelHive(
                        name: name!,
                        description: description!,
                        isDone: [],
                        reireration: selectedDays,
                        tag: _selectedTag!),
                  );
                  Navigator.pop(context);
                },
                backgroundColor: AppColors.primary,
                isValid: name != null &&
                    description != null &&
                    selectedDays.isNotEmpty &&
                    _selectedTag != null,
              )),
        ),
      ),
    );
  }
}
