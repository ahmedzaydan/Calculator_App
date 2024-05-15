import 'package:azulzinho/core/resources/values_manager.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

abstract class ConstantsManager {
  static const int splashDelay = 3;
  static const int sliderAnimationTime = 300;
  static double borderRadius = 10.0.r;
  static const zero = 0;
  static double iconSize = AppSize.s32;
  static const String kitsRegex = '[0-9]';
  static const String valueRegex = r'^\d+(\.\d{0,2})?';
  static const String calculatorRegex = r'^[\d.,\s]+$';
}

enum ToastStates { success, error }