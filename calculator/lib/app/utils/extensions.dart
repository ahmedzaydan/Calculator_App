import 'package:calculator/app/resources/constants_manager.dart';
import 'package:calculator/app/resources/strings_manager.dart';

extension NonNullString on String? {
  String get orEmpty {
    return this ?? StringsManager.emptyString;
  }
}

extension NonNullStringList on List<String>? {
  List<String> get orEmpty {
    return this ?? [];
  }
}

extension NonNullInteger on int? {
  int get orZero {
    return this ?? ConstantsManager.zero;
  }
}

extension NonNullDouble on double? {
  double get orZero {
    return this ?? ConstantsManager.zero.toDouble();
  }
}

extension NonNullBool on bool? {
  bool get orFalse {
    return this ?? false;
  }
}
