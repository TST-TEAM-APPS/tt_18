import 'package:flutter/cupertino.dart';
import 'package:tt_18/core/app_fonts.dart';
import 'package:tt_18/core/colors.dart';

class CustomCupertinoPicker extends StatefulWidget {
  final Function onChange;
  const CustomCupertinoPicker({super.key, required this.onChange});

  @override
  State<CustomCupertinoPicker> createState() => _CustomCupertinoPickerState();
}

class _CustomCupertinoPickerState extends State<CustomCupertinoPicker> {
  int selectedValue = 1;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: AppColors.grey, borderRadius: BorderRadius.circular(20)),
      height: 125,
      padding: const EdgeInsets.symmetric(horizontal: 60),
      child: CupertinoPicker(
        backgroundColor: AppColors.grey,
        selectionOverlay: Container(
          decoration: const BoxDecoration(
            border: Border(
              top: BorderSide(width: 1, color: AppColors.outlineGrey),
              bottom: BorderSide(
                width: 1,
                color: AppColors.outlineGrey,
              ),
            ),
          ),
        ),
        itemExtent: 40,
        onSelectedItemChanged: (int index) {
          setState(() {
            selectedValue = index + 1;
          });
          widget.onChange(selectedValue);
        },
        children: List<Widget>.generate(100, (int index) {
          return Center(
            child: Text(
              (index + 1).toString(),
              style: AppFonts.bodyMedium.copyWith(color: AppColors.white),
            ),
          );
        }),
      ),
    );
  }
}
