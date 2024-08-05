// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class CustomButtons extends StatelessWidget {
  CustomButtons(
      {super.key,
      required this.onTap,
      this.borderRadius,
      required this.buttonColor,
      required this.buttonText,
      required this.fontWeight,
      required this.fontSize,
      required this.height,
      required this.width,
      this.textColor});

  VoidCallback onTap;
  Color buttonColor;
  double? borderRadius;
  Color? textColor;
  String buttonText;
  double fontSize;
  dynamic fontWeight;
  double height;
  double width;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        color: buttonColor,
        borderRadius: BorderRadius.circular(borderRadius ?? 0),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          child: Container(
            padding: const EdgeInsets.all(20),
            child: Center(
              child: Text(
                buttonText,
                style: TextStyle(
                  color: textColor,
                  fontSize: fontSize,
                  fontWeight: fontWeight,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
