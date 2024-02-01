import 'package:calculator/core/resources/color_manager.dart';
import 'package:calculator/core/resources/values_manager.dart';
import 'package:flutter/material.dart';

ThemeData getApplicationTheme() {
  return ThemeData(
    // Main colors
    primaryColor: ColorManager.primary,
    primaryColorLight: ColorManager.lightPrimary,
    primaryColorDark: ColorManager.darkPrimary,
    disabledColor: ColorManager.grey1,
    splashColor: ColorManager.lightPrimary, // Ripple effect color

    // Card view theme
    cardTheme: CardTheme(
      color: ColorManager.white,
      shadowColor: ColorManager.grey,
      elevation: AppSize.s4,
    ),

    // App bar theme
    appBarTheme: AppBarTheme(
      centerTitle: true,
      color: ColorManager.primary,
      elevation: AppSize.s4,
      shadowColor: ColorManager.lightPrimary,
      // titleTextStyle: getRegularStyle(
      //   fontSize: FontSize.s16,
      //   color: ColorManager.white,
      // ),
    ),

    // Button theme
    buttonTheme: ButtonThemeData(
      shape: const StadiumBorder(),
      disabledColor: ColorManager.grey1,
      buttonColor: ColorManager.primary,
      splashColor: ColorManager.lightPrimary,
    ),

    // Elevated button theme
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        // textStyle: getRegularStyle(
        //   fontSize: FontSize.s17,
        //   color: ColorManager.white,
        // ),
        backgroundColor: ColorManager.primary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            AppSize.s12,
          ),
        ),
      ),
    ),

    // Text theme

    // Input decoration theme (text form field)
    inputDecorationTheme: InputDecorationTheme(
      // Content padding style
      contentPadding: const EdgeInsets.all(
        AppPadding.p8,
      ),

      // Hint style
      // hintStyle: getRegularStyle(
      //   fontSize: FontSize.s14,
      //   color: ColorManager.grey,
      // ),

      // Label style
      // labelStyle: getMediumStyle(
      //   fontSize: FontSize.s14,
      //   color: ColorManager.grey,
      // ),

      // Error style
      // errorStyle: getRegularStyle(
      //   fontSize: FontSize.s14,
      //   color: ColorManager.error,
      // ),

      // Enabled border style
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: ColorManager.primary,
          width: AppSize.s1_5,
        ),
        borderRadius: BorderRadius.circular(
          AppSize.s8,
        ),
      ),

      // Focused border style
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: ColorManager.primary,
          width: AppSize.s1_5,
        ),
        borderRadius: BorderRadius.circular(
          AppSize.s8,
        ),
      ),

      // Error border style
      errorBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: ColorManager.error,
          width: AppSize.s1_5,
        ),
        borderRadius: BorderRadius.circular(
          AppSize.s8,
        ),
      ),

      // Focused error border style
      focusedErrorBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: ColorManager.primary,
          width: AppSize.s1_5,
        ),
        borderRadius: BorderRadius.circular(
          AppSize.s8,
        ),
      ),
    ),
  );
}
