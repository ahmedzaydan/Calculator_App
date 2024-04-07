import 'package:calculator/app/resources/constants_manager.dart';
import 'package:calculator/app/resources/font_manager.dart';
import 'package:calculator/app/resources/values_manager.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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

TextStyle getTextStyle({
  double fontSize = FontSize.s22,
}) {
  return TextStyle(
    fontSize: fontSize,
    color: Colors.black,
  );
}

AppBar customAppBar({
  required String text,
  List<Widget>? actions,
  void Function()? onPressed,
  bool leading = true,
}) {
  return AppBar(
    title: Text(
      text,
      style: const TextStyle(
        fontSize: AppSize.s24,
        fontWeight: FontWeight.bold,
      ),
    ),
    actions: actions,
    leading: leading
        ? IconButton(
            icon: const Icon(
              Icons.arrow_back_outlined,
              color: Colors.white,
              size: 32,
            ),
            onPressed: onPressed,
          )
        : null,
  );
}

double roundDouble(double value) {
  return double.parse(value.toStringAsFixed(2));
}

List<TextInputFormatter>? getInputFormatters(String regex) {
  return [
    FilteringTextInputFormatter.allow(RegExp(regex)),
  ];
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

void kprint(dynamic message) {
  if (kDebugMode) {
    print('\n$message\n');
  }
}
