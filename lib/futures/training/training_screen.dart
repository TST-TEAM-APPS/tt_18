import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tt_18/components/custom_current_date_widget.dart';
import 'package:tt_18/core/app_fonts.dart';
import 'package:tt_18/core/colors.dart';
import 'package:tt_18/futures/training/training_details_screen/training_details_screen.dart';

class TrainingScreen extends StatefulWidget {
  const TrainingScreen({super.key});

  @override
  State<TrainingScreen> createState() => _TrainingScreenState();
}

class _TrainingScreenState extends State<TrainingScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              CurrentDateWIdget(
                value: [
                  DateTime.now(),
                ],
                onChangeDate: (value) {
                  // model.onUpdatedDate(value);
                },
              ),
              const SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Today\'s training',
                    style: AppFonts.displayMedium.copyWith(
                      color: AppColors.white,
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => const TrainingDetailsScreen()),
                      );
                    },
                    child: Image.asset(
                      'assets/icons/rounded-plus.png',
                      width: 34,
                      height: 34,
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    ));
  }
}
