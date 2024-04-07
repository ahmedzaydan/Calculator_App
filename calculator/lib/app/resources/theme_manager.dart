import 'package:calculator/app/resources/color_manager.dart';
import 'package:calculator/app/resources/constants_manager.dart';
import 'package:flutter/material.dart';

ThemeData getApplicationTheme() {
  return ThemeData(
    // Main colors
    primaryColor: ColorManager.primary,
    primarySwatch: Colors.primaries[0],
    primaryColorLight: ColorManager.primary,
    disabledColor: ColorManager.primary,

    // App bar theme
    appBarTheme: AppBarTheme(
      centerTitle: true,
      color: ColorManager.primary,
      titleTextStyle: TextStyle(
        color: ColorManager.white,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
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
          ColorManager.primary,
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
