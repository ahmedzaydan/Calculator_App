import 'package:flutter_screenutil/flutter_screenutil.dart';

abstract class ConstantsManager {
  static double borderRadius = 20.r;
  static const zero = 0;
  static double iconSize = 28.sp;

  static const String kitsRegex = '[0-9]';
  static const String valueRegex = r'^\d+(\.\d{0,2})?';
  static const String calculatorRegex = r'[^0-9.\s]';
}

enum ToastStates { success, error }

bool isTablet = true;
