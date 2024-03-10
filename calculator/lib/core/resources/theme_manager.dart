import 'package:calculator/core/resources/color_manager.dart';
import 'package:calculator/core/resources/constants_manager.dart';
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
          color: ColorManager.error,
        ),
        backgroundColor: ColorManager.primary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            ConstantsManager.borderRadius,
          ),
        ),
      ),
    ),

    // text form field theme
    inputDecorationTheme: InputDecorationTheme(
      contentPadding: const EdgeInsets.all(15),
      labelStyle: const TextStyle(
        color: Colors.black,
      ),
      enabledBorder: _decorateBorder(),
      focusedBorder: _decorateBorder(),
      errorBorder: _decorateBorder(),
      focusedErrorBorder: _decorateBorder(),
      disabledBorder: _decorateBorder(),
      border: _decorateBorder(),
    ),

    // icon button theme
    iconButtonTheme: IconButtonThemeData(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(
          ColorManager.primary,
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

OutlineInputBorder _decorateBorder() {
  return OutlineInputBorder(
    borderRadius: BorderRadius.circular(
      ConstantsManager.borderRadius,
    ),
    borderSide: BorderSide(
      color: ColorManager.primary,
      width: 2,
    ),
  );
}
