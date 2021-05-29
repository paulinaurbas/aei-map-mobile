import 'package:flutter/material.dart';

import 'app_colors.dart';

class CustomTheme {
  static ThemeData get lightTheme {
    return ThemeData(
        primaryColor: appColors['primary_app_color'],
        scaffoldBackgroundColor: appColors['background_color'],
        textTheme: ThemeData.dark().textTheme,
        buttonTheme: ButtonThemeData(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(18.0)),
          buttonColor: Colors.white,
        ));
  }
}
