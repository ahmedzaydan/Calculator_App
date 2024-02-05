import 'package:calculator/core/resources/constants_manager.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

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

TextStyle getTextStyle() {
  return const TextStyle(
    fontSize: 18,
    // fontWeight: FontWeight.bold,
    color: Colors.black,
  );
}

AppBar customAppBar({
  required String text,
  List<Widget>? actions,
}) {
  return AppBar(
    title: Text(
      text,
    ),
    actions: actions,
  );
}

double roundDouble(double value) {
  return double.parse(value.toStringAsFixed(4));
}

String getCurrentDate() {
  DateTime now = DateTime.now();
  return '${now.day}/${now.month}/${now.year}';
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
void showCustomToast({
  required String message,
  required ToastStates state,
}) {
  Fluttertoast.showToast(
    msg: message,
    toastLength: Toast.LENGTH_LONG,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 5,
    backgroundColor: colorToast(state),
    textColor: Colors.white,
    fontSize: 18,
  );
}

TextDirection getTextDirection(String text) {
  if (text.contains(RegExp(r'[a-zA-Z]'))) {
    return TextDirection.ltr;
  } else {
    return TextDirection.rtl;
  }
}
