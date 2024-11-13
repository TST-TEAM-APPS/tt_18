import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tt_18/components/custom_button.dart';
import 'package:tt_18/core/app_fonts.dart';
import 'package:tt_18/core/colors.dart';
import 'package:tt_18/futures/home/home_screen.dart';
import 'package:tt_18/futures/onboarding/onb_pages/onb_page_widget.dart';

class Onb extends StatefulWidget {
  const Onb({super.key});

  @override
  State<Onb> createState() => _OnbState();
}

class _OnbState extends State<Onb> {
  late PageController _onbPageController;
  bool isLastPage = false;
  @override
  void initState() {
    _onbPageController = PageController();
    super.initState();
  }

  @override
  void dispose() {
    _onbPageController.dispose();
    super.dispose();
  }

  void woSetHome() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool('showOnb', false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const SizedBox(
            height: 40,
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.8,
            child: PageView(
              controller: _onbPageController,
              onPageChanged: (index) {
                setState(() => isLastPage = index == 2);
              },
              children: const [
                OnbPageWidget(
                  image: 'assets/images/onb1.png',
                  title:
                      'Achieve your fitness goals with your personal trainer and counsellor',
                ),
                OnbPageWidget(
                  image: 'assets/images/onb2.png',
                  title: 'Track your workouts, progress and nutrition',
                ),
                OnbPageWidget(
                  image: 'assets/images/onb3.png',
                  title: 'Start your journey to a healthy lifestyle today!',
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: CustomButton(
              title: 'Continue',
              borderRadius: BorderRadius.circular(12),
              highlightColor: AppColors.white.withOpacity(0.5),
              backgroundColor:
                  isLastPage ? AppColors.primary : AppColors.surface,
              titleStyle: AppFonts.displayMedium.copyWith(color: Colors.white),
              onTap: () {
                if (isLastPage) {
                  woSetHome();
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (_) => const HomeScreen()),
                      (_) => false);
                }
                _onbPageController.nextPage(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut);
              },
            ),
          )
        ],
      ),
    );
  }
}
