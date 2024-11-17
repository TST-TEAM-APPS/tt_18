import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tt_18/futures/home/home_screen.dart';
import 'package:tt_18/futures/onboarding/onb_screen.dart';

class AtSpLpdshSsdreen extends StatefulWidget {
  const AtSpLpdshSsdreen({super.key});

  @override
  State<AtSpLpdshSsdreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<AtSpLpdshSsdreen> {
  @override
  void initState() {
    super.initState();
    _navigateToWelcome();
  }

  Future _navigateToWelcome() async {
    await Future.delayed(const Duration(seconds: 2));
    final sfsdf = await SharedPreferences.getInstance();
    final showSfsdf = sfsdf.getBool('showOnb') ?? false;
    Navigator.pushReplacement(
      // ignore: use_build_context_synchronously
      context,
      MaterialPageRoute(
          builder: (_) => showSfsdf ? const Onb() : const HomeScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/images/back.png'), fit: BoxFit.cover),
        ),
        child: Center(
          child: Image.asset(
            'assets/icons/onb1.png',
            width: 237,
            height: 237,
          ),
        ),
      ),
    );
  }
}
