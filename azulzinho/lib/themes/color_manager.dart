import 'package:flutter/material.dart';

abstract class ColorManager {
  static Color primary = const Color.fromARGB(255, 67, 156, 215);
  static Color iconColor = primary;

  // general colors
  static Color white = const Color(0xffFFFFFF);
  static Color red = const Color(0xffe61f34);
  static Color transparent = const Color(0x00000000);

  // grey colors
  static Color lightGrey = const Color(0xff9E9E9E);
  static Color lightGrey2 = const Color.fromARGB(255, 199, 199, 199);

  static const Color black = Color(0xff000000);

  static Color expired =  Color.fromARGB(255, 219, 219, 219);

  // kit month 30 staus color
  static Color red2 = const Color(0xffe00b0b);

  // kit month 24 staus color
  static Color yellow = const Color(0xfff0C559);

  // kit month 12 staus color
  static Color green = const Color(0xff39E53F);
  static const Color lightGreen = Color(0xff4CAF50);
  static Color darkGreen = const Color(0xff086F08);
}
