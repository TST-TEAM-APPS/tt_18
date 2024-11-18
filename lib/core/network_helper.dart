import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tt_18/futures/onboarding/splash_screen.dart';

class NetworkHelper {
  static void showNoInternetDialog(BuildContext context) => showCupertinoDialog(
        context: context,
        builder: (context) => CupertinoAlertDialog(
          title: const Text('Ooops...'),
          content: const Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "It seems that you don't have an internet",
              ),
            ],
          ),
          actions: [
            CupertinoActionSheetAction(
              onPressed: () => Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(
                  builder: (context) => const SplashScreen(),
                ),
                (_) => false,
              ),
              child: const Text('Try again'),
            ),
          ],
        ),
      );
}
