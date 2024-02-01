import 'package:flutter/material.dart';

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
  required BuildContext context,
  required String text,
  List<Widget>? actions,
}) {
  return AppBar(
    title: Text(
      text,
      style: const TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w500,
        color: Colors.black,
      ),
    ),
    centerTitle: true,
    actions: actions,
  );
}
