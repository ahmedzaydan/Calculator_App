import 'package:azulzinho/core/resources/constants_manager.dart';
import 'package:azulzinho/themes/color_manager.dart';
import 'package:azulzinho/themes/styles_manager.dart';
import 'package:flutter/material.dart';

ThemeData getApplicationTheme() {
  return ThemeData(
    // Main colors
    // primaryColor: ColorManager.primary,
    // primarySwatch: Colors.primaries[0],
    // primarySwatch: Colors.blue,
    // primaryColorLight: ColorManager.primary,
    // disabledColor: ColorManager.primary,

    colorScheme: ColorScheme.light(
      primary: ColorManager.primary,
      secondary: ColorManager.white,
    ),

    // App bar theme
    appBarTheme: AppBarTheme(
      centerTitle: true,
      color: ColorManager.primary,
      titleTextStyle: getBoldStyle(color: ColorManager.white),
      actionsIconTheme: IconThemeData(
        color: ColorManager.white,
      ),
      iconTheme: IconThemeData(
        color: ColorManager.white,
      ),
    ),

    // icon theme
    iconTheme: IconThemeData(
      color: ColorManager.white,
    ),

    // Elevated button theme
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        textStyle: TextStyle(
          color: ColorManager.red,
        ),
        backgroundColor: ColorManager.primary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            ConstantsManager.borderRadius,
          ),
        ),
      ),
    ),

    // icon button theme
    iconButtonTheme: IconButtonThemeData(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(
          ColorManager.transparent,
        ),
        iconColor: MaterialStateProperty.all(
          ColorManager.black,
        ),
        iconSize: MaterialStateProperty.all(
          ConstantsManager.iconSize,
        ),
        padding: MaterialStateProperty.all(
          const EdgeInsets.all(0),
        ),
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
              ConstantsManager.borderRadius,
            ),
          ),
        ),
      ),
    ),

    // divider theme
    dividerColor: ColorManager.black,
  );
}
