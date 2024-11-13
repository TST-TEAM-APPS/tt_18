import 'package:flutter/material.dart';
import 'package:tt_18/core/app_fonts.dart';

class OnbPageWidget extends StatelessWidget {
  final String image;
  final String title;

  const OnbPageWidget({super.key, required this.image, required this.title});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            width: MediaQuery.of(context).size.width - 40,
            child: Text(
              title,
              style: AppFonts.displayLarge.copyWith(color: Colors.white),
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Image.asset(
              image,
              fit: BoxFit.cover,
            ),
          ),
        ],
      ),
    );
  }
}
