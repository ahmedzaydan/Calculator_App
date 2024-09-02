import 'package:azulzinho/themes/color_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

TextStyle getRegularStyle({
  Color color = ColorManager.black,
  double fontSize = 14,
}) {
  return TextStyle(
    fontSize: fontSize.sp,
    fontWeight: FontWeight.w400,
    color: color,
  );
}

TextStyle getMediumStyle({
  Color color = ColorManager.black,
  double fontSize = 16,
}) {
  return TextStyle(
    fontSize: fontSize.sp,
    fontWeight: FontWeight.w500,
    color: color,
  );
}

TextStyle getBoldStyle({
  Color color = ColorManager.black,
  double fontSize = 18,
}) {
  return TextStyle(
    fontSize: fontSize.sp,
    fontWeight: FontWeight.w700,
    color: color,
  );
}
