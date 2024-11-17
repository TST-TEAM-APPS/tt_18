import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tt_18/components/custom_button.dart';
import 'package:tt_18/core/app_fonts.dart';
import 'package:tt_18/core/colors.dart';

class TrainingDetailsThirdScreen extends StatefulWidget {
  final PageController pageController;
  const TrainingDetailsThirdScreen({super.key, required this.pageController});

  @override
  State<TrainingDetailsThirdScreen> createState() =>
      _TrainingDetailsThirdScreenState();
}

class _TrainingDetailsThirdScreenState
    extends State<TrainingDetailsThirdScreen> {
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
        const _TimeSelector(),
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
        const _TimeSelector(),
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
        const _TimeSelector(),
        const SizedBox(
          height: 30,
        ),
        CustomButton(
          onTap: () {
            widget.pageController.nextPage(
                duration: const Duration(microseconds: 500),
                curve: Curves.easeInOut);
          },
          title: 'Save',
          backgroundColor: AppColors.primary,
          // isValid:
          //     selectedDays.isNotEmpty && name != null && description != null,
          borderRadius: BorderRadius.circular(20),
          highlightColor: Colors.white.withOpacity(0.5),
          titleStyle: AppFonts.displayMedium.copyWith(color: AppColors.white),
        )
      ],
    );
  }
}

class _TimeSelector extends StatelessWidget {
  const _TimeSelector({super.key});

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
          Container(
            height: 35,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.primary,
            ),
            child: Center(
              child: Image.asset('assets/icons/rounded-minus.png'),
            ),
          ),
          Text(
            '00:00',
            style: AppFonts.displayMedium.copyWith(color: AppColors.onSurface),
          ),
          Container(
            height: 35,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.primary,
            ),
            child: Center(
              child: Image.asset('assets/icons/rounded-plus.png'),
            ),
          ),
        ],
      ),
    );
  }
}
