import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tt_18/core/colors.dart';
import 'package:tt_18/futures/onboarding/onb_screen.dart';

void main() {
  runApp(const MyApp(
    homeScreen: Onb(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.homeScreen});

  final Widget homeScreen;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'tt_18',
      theme: ThemeData(
          scaffoldBackgroundColor: AppColors.background,
          highlightColor: Colors.transparent,
          splashColor: Colors.transparent,
          bottomSheetTheme:
              const BottomSheetThemeData(backgroundColor: Colors.transparent),
          splashFactory: NoSplash.splashFactory,
          cupertinoOverrideTheme: const CupertinoThemeData(
              textTheme: CupertinoTextThemeData(
            pickerTextStyle: TextStyle(
                color: Color.fromARGB(255, 0, 0, 0),
                fontSize: 23,
                fontWeight: FontWeight.w400),
          ))),
      home: homeScreen,
    );
  }
}
