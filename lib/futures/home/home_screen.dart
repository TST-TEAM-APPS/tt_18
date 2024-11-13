import 'package:flutter/material.dart';
import 'package:tt_18/core/app_fonts.dart';
import 'package:tt_18/core/btm.dart';
import 'package:tt_18/core/colors.dart';
import 'package:tt_18/futures/food/food_screen.dart';
import 'package:tt_18/futures/main/main_screen.dart';
import 'package:tt_18/futures/settings/settings_screen.dart';
import 'package:tt_18/futures/training/training_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  final List<PageModel> _pages = [
    PageModel(
      page: const MainScreen(),
      iconPath: 'assets/icons/main.png',
    ),
    PageModel(
      page: const TrainingScreen(),
      iconPath: 'assets/icons/training.png',
    ),
    PageModel(
      page: const FoodScreen(),
      iconPath: 'assets/icons/food.png',
    ),
    PageModel(
      page: const SettingsScreen(),
      iconPath: 'assets/icons/settings.png',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex].page,
      bottomNavigationBar: WoDownBar(
        onPageChanged: (index) {
          _currentIndex = index;
          setState(() {});
        },
        pages: _pages,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            height: 48,
            width: 48,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (_pages[index].iconPath != null)
                  Image.asset(
                    _pages[index].iconPath!,
                    color: _currentIndex == index
                        ? AppColors.primary
                        : AppColors.outlineGrey,
                    width: 24,
                  ),
                if (_pages[index].title != null)
                  const SizedBox(
                    height: 3,
                  ),
                if (_pages[index].title != null)
                  Text(
                    _pages[index].title!,
                    style: AppFonts.displaySmall.copyWith(
                      color: _currentIndex == index
                          ? Colors.white
                          : AppColors.outlineGrey,
                    ),
                  )
              ],
            ),
          );
        },
      ),
    );
  }
}
