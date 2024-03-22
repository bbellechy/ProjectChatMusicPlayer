import 'package:flutter/material.dart';

ThemeData lighmode = ThemeData(
  colorScheme: ColorScheme.light(
    background: Color.fromARGB(255, 252, 177, 124), //Colors.grey.shade300 
    primary: Colors.grey.shade500, //4B2013
    secondary: Colors.grey.shade200,
    inversePrimary: Colors.grey.shade900,
  ),
  appBarTheme: AppBarTheme(
    backgroundColor:  Color.fromARGB(255, 226, 155, 97)
  ),
);