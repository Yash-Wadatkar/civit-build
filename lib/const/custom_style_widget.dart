import 'package:flutter/material.dart';

class CustomTextStyle {
  // A method that returns a TextStyle with customizable fontSize, color, and fontWeight
  static TextStyle textStyle({
    double fontSize = 16.0,
    Color color = Colors.black,
    FontWeight fontWeight = FontWeight.normal,
  }) {
    return TextStyle(
      fontSize: fontSize,
      color: color,
      fontWeight: fontWeight,
    );
  }
}
