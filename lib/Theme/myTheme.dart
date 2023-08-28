import 'package:flutter/material.dart';

class myTheme{
  static ThemeData theme =ThemeData(
    appBarTheme: AppBarTheme(
      color: Colors.transparent,
      elevation: 0,
      centerTitle: true
    ),
    primaryTextTheme: TextTheme(
      headline1: TextStyle(color: Colors.white,
      fontSize: 20,
      fontWeight: FontWeight.bold),
    )
  );
}