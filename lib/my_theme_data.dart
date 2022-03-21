import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyThemeData {
  static const Color lightScaffoldBackground =
      Color.fromARGB(255, 223, 236, 219);
  static final ThemeData lightTheme = ThemeData(
      primarySwatch: Colors.blue,
      scaffoldBackgroundColor: lightScaffoldBackground,
      textTheme: TextTheme(
        subtitle1: TextStyle(
          color: Colors.black,
          fontSize: 18,
        ),
        subtitle2: TextStyle(
          color: Colors.black26,
          fontSize: 14,
        ),
      ));
}
