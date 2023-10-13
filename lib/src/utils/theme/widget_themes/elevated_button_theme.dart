import 'package:flutter/material.dart';

import '../../../constants/colors.dart';
import '../../../constants/sizes.dart';

class TElevatedButtonTheme {
  TElevatedButtonTheme._();

  //light theme
  static final lightElevatedButtonTheme = ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      foregroundColor: tPrimaryColor,
      backgroundColor: tSecondaryColor,
      side: BorderSide(color: tSecondaryColor),
      padding: EdgeInsets.symmetric(vertical: tSButtonHeight),
    ),
  );

  //DARK THEME
  static final darkElevatedButtonTheme = ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      foregroundColor: tPrimaryColor,
      backgroundColor: tSecondaryColor,
      side: BorderSide(color: tSecondaryColor),
      padding: EdgeInsets.symmetric(vertical: tSButtonHeight),
    ),
  );
}
