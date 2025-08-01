import 'package:flutter/material.dart';

ThemeData lightMode = ThemeData(
  scaffoldBackgroundColor: Colors.grey.shade300,
  colorScheme: ColorScheme.light(
    brightness: Brightness.light,
    primary: Colors.black,
    secondary: Colors.grey.shade500,
    tertiary: Colors.grey.shade800,
  )
);