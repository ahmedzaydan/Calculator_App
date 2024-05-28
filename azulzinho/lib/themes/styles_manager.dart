import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

TextStyle getLightStyle({
  Color? color,
}) {
  return TextStyle(
    fontSize: 12.sp,
    fontWeight: FontWeight.w300,
    color: color,
  );
}

TextStyle getRegularStyle({
  Color? color,
}) {
  return TextStyle(
    fontSize: 14.sp,
    fontWeight: FontWeight.w400,
    color: color,
  );
}

TextStyle getMediumStyle({
  Color? color,
}) {
  return TextStyle(
    fontSize: 16.sp,
    fontWeight: FontWeight.w500,
    color: color,
  );
}

TextStyle getBoldStyle({
  Color? color,
}) {
  return TextStyle(
    fontSize: 18.sp,
    fontWeight: FontWeight.w700,
    color: color,
  );
}

