import 'package:flutter/material.dart';

TextStyle textStyle(
  Color color,
  FontWeight weight,
  double size, {
  FontStyle style = FontStyle.normal,
  double lineHeight = 1,
  TextDecoration? decoration,
}) {
  return TextStyle(
    color: color,
    fontWeight: weight,
    fontSize: size,
    height: lineHeight,
    decoration: decoration,
  );
}
