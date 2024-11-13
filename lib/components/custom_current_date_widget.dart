
import 'package:flutter/material.dart';
import 'package:tt_18/core/app_fonts.dart';
import 'package:tt_18/core/colors.dart';

class CurrentDateWIdget extends StatelessWidget {
  const CurrentDateWIdget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Text(
              '03',
              style:
                  AppFonts.displayLarge.copyWith(color: AppColors.onBackground),
            ),
            const SizedBox(
              width: 10,
            ),
            Text(
              'Tuesday,\nSeptember',
              style:
                  AppFonts.bodyMedium.copyWith(color: AppColors.onBackground),
            ),
          ],
        ),
        Image.asset(
          'assets/icons/calendar.png',
          width: 24,
          height: 24,
          fit: BoxFit.cover,
        )
      ],
    );
  }
}

