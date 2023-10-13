import 'package:flutter/material.dart';
import 'package:logstock/src/utils/theme/widget_themes/elevated_button_theme.dart';
import 'package:logstock/src/utils/theme/widget_themes/outlined_button_theme.dart';
import 'package:logstock/src/utils/theme/widget_themes/text_theme.dart';

class TAppTheme {
  TAppTheme._();
  static ThemeData lightTheme = ThemeData(
      brightness: Brightness.light,
      // ignore: prefer_const_constructors
      textTheme: TTextTheme.lightTextTheme,
      outlinedButtonTheme: TOutlinedButtonTheme.lightOutlinedButtonTheme,
      elevatedButtonTheme: TElevatedButtonTheme.lightElevatedButtonTheme);

  static ThemeData darkTheme = ThemeData(
      brightness: Brightness.dark,
      textTheme: TTextTheme.darkTextTheme,
      outlinedButtonTheme: TOutlinedButtonTheme.darkOutlinedButtonTheme,
      elevatedButtonTheme: TElevatedButtonTheme.darkElevatedButtonTheme);
}
