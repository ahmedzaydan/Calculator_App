import 'package:calculator/app/resources/color_manager.dart';
import 'package:calculator/app/resources/constants_manager.dart';
import 'package:calculator/app/resources/strings_manager.dart';
import 'package:calculator/features/kits/kit_cubit/kit_cubit.dart';
import 'package:calculator/features/kits/models/kit_type.dart';

extension NonNullString on String? {
  String get orEmpty {
    return this ?? StringsManager.emptyString;
  }
}

extension ToDouble on String {
  double toDouble() {
    return double.parse(this);
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

extension KitTypeExtension on KitStatus {
  KitType get kitType {
    switch (this) {
      case KitStatus.transparent:
        return KitType();
      case KitStatus.month12:
        return KitType(
          typeString: StringsManager.month12,
          backgroundColor: ColorManager.month12,
        );
      case KitStatus.month24:
        return KitType(
          typeString: StringsManager.month24,
          backgroundColor: ColorManager.month24,
        );
      case KitStatus.month30:
        return KitType(
          typeString: StringsManager.month30,
          backgroundColor: ColorManager.month30,
        );
      case KitStatus.expired:
        return KitType(
          typeString: StringsManager.expired,
          backgroundColor: ColorManager.expired,
        );
    }
  }
}

extension NumericKitStatusExtension on KitStatus {
  int get numericValue {
    switch (this) {
      case KitStatus.transparent:
        return 0;
      case KitStatus.month12:
        return 1;
      case KitStatus.month24:
        return 2;
      case KitStatus.month30:
        return 3;
      case KitStatus.expired:
        return 4;
    }
  }
}
