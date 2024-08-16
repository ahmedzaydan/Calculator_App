import 'package:azulzinho/core/resources/constants_manager.dart';
import 'package:azulzinho/themes/color_manager.dart';
import 'package:azulzinho/themes/styles_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

ThemeData getApplicationTheme() {
  return ThemeData(
    colorScheme: ColorScheme.light(
      primary: ColorManager.primary,
      secondary: ColorManager.white,
    ),

    // App bar theme
    appBarTheme: AppBarTheme(
      centerTitle: true,
      color: ColorManager.primary,
      titleTextStyle: getMediumStyle(
        color: ColorManager.white,
        fontSize: 20,
      ),
      actionsIconTheme: IconThemeData(
        color: ColorManager.white,
      ),
      iconTheme: IconThemeData(
        color: ColorManager.white,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(
            ConstantsManager.borderRadius * 2,
          ),
          bottomRight: Radius.circular(
            ConstantsManager.borderRadius * 2,
          ),
        ),
      ),
      toolbarHeight: 70.h,
    ),

    // icon theme
    iconTheme: IconThemeData(
      color: ColorManager.white,
      size: ConstantsManager.iconSize,
    ),

    // icon button theme
    iconButtonTheme: IconButtonThemeData(
      style: ButtonStyle(
        backgroundColor: WidgetStateProperty.all(
          ColorManager.transparent,
        ),
        iconColor: WidgetStateProperty.all(
          ColorManager.black,
        ),
        iconSize: WidgetStateProperty.all(
          ConstantsManager.iconSize,
        ),
        padding: WidgetStateProperty.all(
          const EdgeInsets.all(0),
        ),
        shape: WidgetStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
              ConstantsManager.borderRadius,
            ),
          ),
        ),
      ),
    ),

    // divider theme
    dividerTheme: DividerThemeData(
      color: ColorManager.black,
      thickness: 1.5.sp,
    ),
  );
}
