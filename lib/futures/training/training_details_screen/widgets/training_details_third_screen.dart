import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tt_18/components/custom_button.dart';
import 'package:tt_18/core/app_fonts.dart';
import 'package:tt_18/core/colors.dart';

class TrainingDetailsThirdScreen extends StatefulWidget {
  final PageController pageController;
  final Function onNext;
  final int? workingTime;
  final int? restTime;
  final int? preps;

  const TrainingDetailsThirdScreen(
      {super.key,
      required this.pageController,
      required this.onNext,
      this.workingTime,
      this.restTime,
      this.preps});

  @override
  State<TrainingDetailsThirdScreen> createState() =>
      _TrainingDetailsThirdScreenState();
}

class _TrainingDetailsThirdScreenState
    extends State<TrainingDetailsThirdScreen> {
  int workingTime = 0;
  int restTime = 0;
  int numberOfPreps = 0;

  @override
  void initState() {
    if (widget.workingTime != null) {
      workingTime = widget.workingTime!;
    }
    if (widget.restTime != null) {
      restTime = widget.restTime!;
    }
    if (widget.preps != null) {
      numberOfPreps = widget.preps!;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Working time',
          style: AppFonts.displayMedium.copyWith(
            color: AppColors.onBackground,
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        _TimeSelector(
          initialValue: workingTime,
          onChange: (value) {
            workingTime = value;
            setState(() {});
          },
        ),
        const SizedBox(
          height: 30,
        ),
        Text(
          'Rest time',
          style: AppFonts.displayMedium.copyWith(
            color: AppColors.onBackground,
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        _TimeSelector(
          initialValue: restTime,
          onChange: (value) {
            restTime = value;
            setState(() {});
          },
        ),
        const SizedBox(
          height: 30,
        ),
        Text(
          'Number of repetitions',
          style: AppFonts.displayMedium.copyWith(
            color: AppColors.onBackground,
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        _TimeSelector(
          initialValue: numberOfPreps,
          onChange: (value) {
            numberOfPreps = value;
            setState(() {});
          },
        ),
        const SizedBox(
          height: 30,
        ),
        CustomButton(
          onTap: () {
            widget.onNext(workingTime, restTime, numberOfPreps);
            widget.pageController.nextPage(
                duration: const Duration(microseconds: 500),
                curve: Curves.easeInOut);
          },
          title: 'Save',
          backgroundColor: AppColors.primary,
          isValid: workingTime != 0 && restTime != 0 && numberOfPreps != 0,
          borderRadius: BorderRadius.circular(20),
          highlightColor: Colors.white.withOpacity(0.5),
          titleStyle: AppFonts.displayMedium.copyWith(color: AppColors.white),
        )
      ],
    );
  }
}

class _TimeSelector extends StatefulWidget {
  final int? initialValue;
  final Function onChange;
  const _TimeSelector({super.key, required this.onChange, this.initialValue});

  @override
  State<_TimeSelector> createState() => _TimeSelectorState();
}

class _TimeSelectorState extends State<_TimeSelector> {
  int value = 0;
  String _formatTime(int minutes) {
    final hours = minutes ~/ 60;
    final remainingMinutes = minutes % 60;
    return '${hours.toString().padLeft(2, '0')}:${remainingMinutes.toString().padLeft(2, '0')}';
  }

  @override
  void initState() {
    if (widget.initialValue != null) {
      value = widget.initialValue!;
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 35,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: AppColors.surface,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () {
              if (value == 0) {
                return;
              }
              value -= 1;
              widget.onChange(value);
              setState(() {});
            },
            child: Container(
              height: 35,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.primary,
              ),
              child: Center(
                child: Image.asset('assets/icons/rounded-minus.png'),
              ),
            ),
          ),
          Text(
            _formatTime(value),
            style: AppFonts.displayMedium.copyWith(color: AppColors.onSurface),
          ),
          GestureDetector(
            onTap: () {
              value += 1;
              widget.onChange(value);
              setState(() {});
            },
            child: Container(
              height: 35,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.primary,
              ),
              child: Center(
                child: Image.asset('assets/icons/rounded-plus.png'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
