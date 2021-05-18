import 'package:flutter/material.dart';

final ThemeData theme = ThemeData(
  primarySwatch: Colors.orange,
  primaryColor: Color(0XFF0C0C0C),
  accentColor: Colors.white,
  scaffoldBackgroundColor: Color(0XFF0C0C0C),
  brightness: Brightness.dark,
  fontFamily: 'Acme',
  appBarTheme: AppBarTheme(elevation: 0, centerTitle: true),
  errorColor: Colors.deepOrange,
  inputDecorationTheme: InputDecorationTheme(
    errorBorder: UnderlineInputBorder(
      borderSide: BorderSide(
        width: 2,
        color: Colors.deepOrange,
      ),
    ),
    enabledBorder: UnderlineInputBorder(
      borderSide: BorderSide(
        width: 2,
        color: Colors.white,
      ),
    ),
    border: UnderlineInputBorder(
      borderSide: BorderSide(width: 10),
    ),
  ),
  snackBarTheme: SnackBarThemeData(
    contentTextStyle: TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.w600,
      fontSize: 16,
    ),
    backgroundColor: Colors.transparent,
  ),
);
