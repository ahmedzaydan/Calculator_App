import 'package:calculator/app/resources/values_manager.dart';

abstract class ConstantsManager {
  static const int splashDelay = 3;
  static const int sliderAnimationTime = 300;
  static const borderRadius = 10.0;
  static const zero = 0;
  static const double iconSize = AppSize.s32;
  static const String kitsRegex = '[0-9]';
  static const String valueRegex = r'^\d+(\.\d{0,2})?';
  static const String calculatorRegex = r'^[\d.,\s]+$';
}

enum ToastStates { success, error }

enum AppState {
  loading,
  success,
  error,
}

enum ItemType {
  kit,
  person,
}

enum ItemAction {
  add,
  load,
  update,
  delete,
}
