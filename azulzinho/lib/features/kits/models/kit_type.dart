import 'package:azulzinho/app/resources/strings_manager.dart';
import 'package:flutter/material.dart';

class KitType {
  String typeString;
  Color backgroundColor;

  KitType({
    this.typeString = KitsStrings.normal,
    this.backgroundColor = Colors.transparent,
  });
}
