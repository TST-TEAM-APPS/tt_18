// ignore_for_file: use_build_context_synchronously
import 'package:flutter/material.dart';
import 'package:in_app_review/in_app_review.dart';
import 'package:is_first_run/is_first_run.dart';
import 'package:tt_18/core/network_helper.dart';
import 'package:tt_18/core/mixins/network_mixin.dart';
import 'package:tt_18/futures/home/home_screen.dart';
import 'package:tt_18/futures/onboarding/onb_screen.dart';
import 'package:tt_18/futures/settings/privacy_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with NetworkMixin {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) => _init());
    super.initState();
  }

  Future<void> _init() async {
    await checkConnection(
      onError: () => NetworkHelper.showNoInternetDialog(
        context,
        
      ),
    );

    final isFirstRun = await IsFirstRun.isFirstRun();

    if (isFirstRun) {
      InAppReview.instance.requestReview();
    }

    if (!canNavigate) {
      if (isFirstRun) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const Onb()),
        );
      } else {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => const HomeScreen(),
          ),
        );
      }
    } else {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => const PrivacyScreen(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold();
  }
}
