import 'package:azulzinho/core/resources/constants_manager.dart';
import 'package:azulzinho/core/resources/values_manager.dart';
import 'package:azulzinho/themes/color_manager.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

Color colorToast(ToastStates state) {
  Color color;
  if (state == ToastStates.success) {
    color = Colors.green;
  } else if (state == ToastStates.error) {
    color = Colors.red;
  } else {
    color = Colors.amber;
  }
  return color;
}

// custom showToast
void showCustomToast(String message, ToastStates state) {
  Fluttertoast.showToast(
    msg: message,
    fontSize: AppSize.s18,
    timeInSecForIosWeb: 5,
    textColor: ColorManager.white,
    gravity: ToastGravity.BOTTOM,
    toastLength: Toast.LENGTH_LONG,
    backgroundColor: colorToast(state),
  );
}
