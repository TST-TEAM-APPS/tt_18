import 'package:flutter/material.dart';

import 'package:tt_18/core/app_fonts.dart';
import 'package:tt_18/core/colors.dart';
import 'package:tt_18/futures/training/training_details_screen/widgets/training_details_first_screen.dart';
import 'package:tt_18/futures/training/training_details_screen/widgets/training_details_second_screen.dart';
import 'package:tt_18/futures/training/training_details_screen/widgets/training_details_third_screen.dart';

class TrainingDetailsScreen extends StatefulWidget {
  const TrainingDetailsScreen({super.key});

  @override
  State<TrainingDetailsScreen> createState() => _TrainingDetailsScreenState();
}

class _TrainingDetailsScreenState extends State<TrainingDetailsScreen> {
  late PageController _pageController;
  int? selectedCard;

  @override
  void initState() {
    _pageController = PageController();
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
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
                      ),
                      TrainingDetailsSeconsScreen(
                        pageController: _pageController,
                      ),
                      TrainingDetailsThirdScreen(
                        pageController: _pageController,
                      )
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
