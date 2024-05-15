import 'package:flutter/material.dart';

abstract class ColorManager {
  static Color primary = const Color.fromARGB(255, 67, 156, 215);
  static Color primaryLight = const Color.fromARGB(255, 120, 181, 221);
  static Color iconColor = primary;

  // general colors
  static Color white = const Color(0xffFFFFFF);
  static Color red = const Color(0xffe61f34);
  static Color transparent = const Color(0x00000000);

  // grey colors
  static Color grey = const Color(0xff737477);
  static Color grey2 = const Color(0xff797979);
  static Color grey1 = const Color(0xff707070);
  static Color darkGrey = const Color(0xff525252);
  static Color lightGrey = const Color(0xff9E9E9E);
  static Color lightGrey2 = Colors.grey[700]!;
  static Color lightGrey3 = const Color(0xFFEEEEEE);
  static Color lightGrey4 = const Color.fromARGB(255, 199, 199, 199);

  static Color black = const Color(0xff000000);
  static Color black38 = const Color(0xFF000000).withOpacity(0.38);
  // 0x26 for the alpha channel
  static Color black26 = const Color(0x26000000);

  static Color expired = const Color.fromARGB(255, 219, 219, 219);

  // kit month 30 staus color
  static Color red2 = const Color(0xffe00b0b);

  // kit month 24 staus color
  static Color yellow = const Color(0xfff0C559);

  // kit month 12 staus color
  static Color green = const Color(0xff39E53F);
}
