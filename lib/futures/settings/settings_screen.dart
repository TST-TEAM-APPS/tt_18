import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tt_18/core/app_fonts.dart';
import 'package:tt_18/core/colors.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
            children: [
              const _SettingLabelWidget(),
              _SettingItemWidget(
                title: 'Version',
                onTap: () {},
              ),
              const SizedBox(
                height: 20,
              ),
              _SettingItemWidget(
                title: 'Rate us',
                onTap: () {},
              ),
              const SizedBox(
                height: 20,
              ),
              _SettingItemWidget(
                title: 'Terms of Use',
                onTap: () {},
              ),
              const SizedBox(
                height: 20,
              ),
              _SettingItemWidget(
                title: 'About us',
                onTap: () {},
              ),
              const SizedBox(
                height: 20,
              ),
              _SettingItemWidget(
                title: 'Privacy Policy',
                onTap: () {},
              ),
            ],
          ),
        ),
      ),
    ));
  }
}

class _SettingLabelWidget extends StatelessWidget {
  const _SettingLabelWidget();

  @override
  Widget build(BuildContext context) {
    return Text(
      'Setting',
      style: AppFonts.displayLarge.copyWith(
        color: AppColors.onBackground,
      ),
    );
  }
}

class _SettingItemWidget extends StatelessWidget {
  final String title;
  final Function onTap;
  const _SettingItemWidget({
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        highlightColor: Colors.white.withOpacity(0.5),
        onTap: () => onTap,
        child: Container(
          padding: const EdgeInsets.only(bottom: 20),
          decoration: const BoxDecoration(
              color: Colors.transparent,
              border: Border(
                  bottom: BorderSide(
                width: 1,
                color: AppColors.primary,
              ))),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: AppFonts.bodyLarge.copyWith(
                  color: AppColors.onBackground,
                ),
              ),
              Image.asset(
                'assets/icons/arrow-left.png',
                width: 36,
                height: 36,
                fit: BoxFit.cover,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
