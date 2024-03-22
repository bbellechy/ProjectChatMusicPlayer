import 'package:chatmusic/themes/dark_mode.dart';
import 'package:chatmusic/themes/light_mode.dart';
import 'package:flutter/material.dart';

class ThemeProvider extends ChangeNotifier {
  // initially light mode 
  ThemeData _themeData = lighmode;
  // get theme
  ThemeData get themeData => _themeData;
  // is dark mode
  bool get isDarkMode => _themeData == darkmode;
  // set theme
  set themeData(ThemeData themeData){
    _themeData = themeData;
    // update UI
    notifyListeners();
  }
  // ใช้สลับสี dark กับ light
  void toggleTheme(){
    if(_themeData == lighmode){
      themeData = darkmode;
    } else {
      themeData = lighmode;
    }
  }
}