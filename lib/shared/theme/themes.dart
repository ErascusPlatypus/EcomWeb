import 'package:flutter/material.dart';

final ThemeData yellowWhiteTheme = ThemeData(
  primaryColor: Colors.yellow[700],
  hintColor: Colors.yellowAccent,
  backgroundColor: Colors.white,
  scaffoldBackgroundColor: Colors.white,
  textTheme: TextTheme(
    displayLarge: TextStyle(
      fontSize: 20.0,
      fontWeight: FontWeight.bold,
      color: Colors.black, // Black text
    ),
    titleLarge: TextStyle(
      fontSize: 20.0,
      fontWeight: FontWeight.bold,
      color: Colors.black87, // Black text
    ),
    bodyLarge: TextStyle(
      fontSize: 16.0,
      color: Colors.black87, // Black text
    ),
    bodyMedium: TextStyle(
      fontSize: 14.0,
      color: Colors.black87, // Black text
    ),
    bodySmall: TextStyle(
      fontSize: 12.0,
      color: Colors.black54, // Black text
    ),
  ),
  appBarTheme: AppBarTheme(
    backgroundColor: Colors.yellow[700],
    titleTextStyle: TextStyle(
      color: Colors.black87,
      fontSize: 20.0,
      fontWeight: FontWeight.bold,
    ),
  ),
  buttonTheme: ButtonThemeData(
    buttonColor: Colors.yellow[700],
    textTheme: ButtonTextTheme.primary,
  ),
);

final Map<String, TextStyle> customTextStyles = {
  'headline1Yellow': TextStyle(
    fontSize: 32.0,
    fontWeight: FontWeight.bold,
    color: Colors.yellow[700],
  ),
  'headline6Yellow': TextStyle(
    fontSize: 20.0,
    fontWeight: FontWeight.bold,
    color: Colors.yellow[700],
  ),
  'bodyText1Yellow': TextStyle(
    fontSize: 16.0,
    color: Colors.yellow[700],
    fontWeight: FontWeight.w600,
    fontFamily: 'OpenSans',
  ),
  'bodyText2Yellow': TextStyle(
    fontSize: 14.0,
    color: Colors.yellow[700],
  ),
  'captionYellow': TextStyle(
    fontSize: 12.0,
    color: Colors.yellow[700],
  ),
};