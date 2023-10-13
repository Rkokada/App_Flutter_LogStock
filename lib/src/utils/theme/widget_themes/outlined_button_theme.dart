import 'package:flutter/material.dart';
import 'package:logstock/src/constants/sizes.dart';

import '../../../constants/colors.dart';

class TOutlinedButtonTheme {
  TOutlinedButtonTheme._();

  //light theme
  static final lightOutlinedButtonTheme = OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      foregroundColor: tSecondaryColor,
      side: BorderSide(color: tSecondaryColor),
      padding: EdgeInsets.symmetric(vertical: tSButtonHeight),
    ),
  );

  //DARK THEME
  static final darkOutlinedButtonTheme = OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      foregroundColor: tPrimaryColor,
      side: BorderSide(color: tPrimaryColor),
      padding: EdgeInsets.symmetric(vertical: tSButtonHeight),
    ),
  );
}
