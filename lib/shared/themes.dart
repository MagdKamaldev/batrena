import 'package:batrena/shared/colors.dart';
import 'package:flutter/material.dart';

ThemeData lightTheme = ThemeData(
  scaffoldBackgroundColor: celeste,
  appBarTheme: AppBarTheme(
      backgroundColor: carrebianCurrent, toolbarHeight: 80, centerTitle: true),
  colorScheme: ColorScheme.fromSeed(seedColor: carrebianCurrent),
  textTheme: TextTheme(
    bodyLarge: TextStyle(
        fontSize: 25,
        fontWeight: FontWeight.bold,
        fontFamily: "Inter",
        color: lavendarBlush),
    bodyMedium: TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.w500,
      fontFamily: "Inter",
      decorationColor: lavendarBlush,
    ),
  ),
  useMaterial3: true,
);
