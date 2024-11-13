import 'package:flutter/material.dart';
import 'package:tt_18/core/app_fonts.dart';
import 'package:tt_18/core/colors.dart';

class CustomTextField extends StatefulWidget {
  final Function onChange;
  const CustomTextField({super.key, required this.onChange});

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  late FocusNode _focusNode;
  late TextEditingController _textEditingController;

  @override
  void initState() {
    _focusNode = FocusNode();
    _textEditingController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      focusNode: _focusNode,
      controller: _textEditingController,
      style: AppFonts.bodyMedium.copyWith(color: AppColors.white),
      cursorColor: AppColors.white,
      onTapOutside: (event) {
        _focusNode.unfocus();
      },
      onChanged: (value) {
        widget.onChange(value);
      },
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
        fillColor: AppColors.grey,
        filled: true,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30), // Круглый border
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(
              30), // Круглый border для активного состояния
          borderSide:
              const BorderSide(color: AppColors.background), // Цвет рамки
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius:
              BorderRadius.circular(30), // Круглый border для состояния фокуса
          borderSide: const BorderSide(
              color: AppColors.outlineGrey), // Цвет рамки при фокусе
        ),
      ),
    );
  }
}
