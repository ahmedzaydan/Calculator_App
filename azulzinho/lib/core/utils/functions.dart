import 'dart:developer';

import 'package:azulzinho/core/resources/constants_manager.dart';
import 'package:azulzinho/core/resources/strings_manager.dart';
import 'package:azulzinho/core/resources/values_manager.dart';
import 'package:azulzinho/core/widgets/custom_back_arrow.dart';
import 'package:azulzinho/themes/color_manager.dart';
import 'package:azulzinho/themes/styles_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';

/// UI functions
void navigateTo({
  required BuildContext context,
  required Widget dest,
}) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => dest,
    ),
  );
}

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

// custom alert dialog
void showCustomDialog({
  required BuildContext context,
  required String message,
  required Function onOk,
}) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        backgroundColor: ColorManager.white,
        actionsAlignment: MainAxisAlignment.spaceBetween,
        content: Text(
          message,
          style: getMediumStyle(),
        ),
        actions: [
          // ok button
          TextButton(
            onPressed: () {
              onOk();
              Navigator.pop(context);
            },
            child: Text(
              StringsManager.delete,
              style: getBoldStyle(color: ColorManager.red),
            ),
          ),

          // cancel button
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text(
              StringsManager.cancel,
              style: getBoldStyle(),
            ),
          ),
        ],
      );
    },
  );
}

AppBar customAppBar({
  required BuildContext context,
  required String title,
  List<Widget>? actions,
}) {
  return AppBar(
    toolbarHeight: 0.09.sh,
    leading: CustomBackArrow(context),
    titleSpacing: 0.0,
    title: Padding(
      padding: EdgeInsets.only(
        right: 10.w,
      ),
      child: Text(
        title,
        style: getBoldStyle(color: ColorManager.white),
        softWrap: true,
        maxLines: 3,
        overflow: TextOverflow.ellipsis,
        // textAlign: TextAlign.center,
      ),
    ),
    actions: actions,
  );
}

double formatDobule(double value) {
  return double.parse(value.toStringAsFixed(2));
}

List<TextInputFormatter>? getInputFormatters(String regex) {
  return [
    FilteringTextInputFormatter.allow(RegExp(regex)),
  ];
}

String getDateAsString({
  DateTime? date,
}) {
  date = date ?? DateTime.now();
  return '${date.day}/${date.month}/${date.year}';
}

DateTime getFormattedDate({
  DateTime? date,
}) {
  date = date ?? DateTime.now();
  return DateTime(
    date.year,
    date.month,
    date.day,
  );
}

TextDirection getTextDirection(String text) {
  if (text.contains(RegExp(r'[a-zA-Z]'))) {
    return TextDirection.ltr;
  } else {
    return TextDirection.rtl;
  }
}

void kprint(dynamic message) {
  klog('$message\n');
}

void klog(dynamic message) {
  log(message);
}
