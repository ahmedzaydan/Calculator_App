import 'package:flutter/material.dart';

abstract class ColorManager {
  static Color primary = const Color.fromARGB(255, 67, 156, 215);

  static Color grey = const Color(0xff737477);
  static Color grey2 = const Color(0xff797979);
  static Color grey1 = const Color(0xff707070);
  static Color darkGrey = const Color(0xff525252);
  static Color lightGrey = const Color(0xff9E9E9E);
  static Color lightGrey2 = Colors.grey[700]!;
  static Color lightGrey3 = const Color(0xFFEEEEEE);

  static Color white = const Color(0xffFFFFFF);
  static Color red = const Color(0xffe61f34);
  static Color transparent = const Color(0x00000000);

  static Color black = const Color(0xff000000);
  static Color black38 = const Color(0xFF000000).withOpacity(0.38);
  // 0x26 for the alpha channel
  static Color black26 = const Color(0x26000000);

  static Color expired = const Color(0xffBFBFBF);
  static Color month30 = const Color(0xffe00b0b);
  static Color month24 = const Color(0xfff0C559);
  static Color month24Lighter = const Color(0xffffD640);
  static Color month12 = const Color(0xff39E53F);
}
