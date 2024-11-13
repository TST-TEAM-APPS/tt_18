import 'package:flutter/material.dart';

enum _Variant { standart, alert }

class CustomButton extends StatefulWidget {
  final String title;
  final TextStyle? titleStyle;
  final Color? backgroundColor;
  final Color? highlightColor;
  final EdgeInsetsGeometry? padding;
  final BorderRadius? borderRadius;
  final double? width;
  final Function onTap;
  final _Variant _variant;

  const CustomButton(
      {super.key,
      required this.title,
      this.titleStyle,
      this.backgroundColor,
      this.highlightColor,
      this.padding,
      this.width,
      this.borderRadius,
      required this.onTap})
      : _variant = _Variant.standart;

  const CustomButton.alert(
      {super.key,
      required this.title,
      this.highlightColor,
      required this.onTap,
      this.titleStyle,
      this.width,
      this.borderRadius,
      this.padding})
      : backgroundColor = Colors.transparent,
        _variant = _Variant.alert;

  @override
  State<CustomButton> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  @override
  Widget build(BuildContext context) {
    return Material(
      color: widget.backgroundColor,
      borderRadius: widget.borderRadius,
      child: InkWell(
        highlightColor: widget.highlightColor ?? Colors.white.withOpacity(0.7),
        borderRadius: widget.borderRadius,
        onTap: () {
          widget.onTap();
        },
        child: Container(
            padding: widget.padding ??
                EdgeInsets.symmetric(
                    vertical: widget._variant == _Variant.alert ? 5 : 10,
                    horizontal: widget._variant == _Variant.alert ? 10 : 0),
            width: widget.width ??
                (widget._variant == _Variant.standart ? double.infinity : null),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
              color: Colors.transparent,
            ),
            child: widget._variant == _Variant.standart
                ? Center(
                    child: Text(
                      widget.title,
                      style: widget.titleStyle,
                    ),
                  )
                : Text(
                    widget.title,
                    style: widget.titleStyle,
                  )),
      ),
    );
  }
}
