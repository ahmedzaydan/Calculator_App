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
