import 'package:calculator/app/resources/strings_manager.dart';
import 'package:flutter/material.dart';

class KitType {
  String typeString;
  Color backgroundColor;

  KitType({
    this.typeString = StringsManager.emptyString,
    this.backgroundColor = Colors.transparent,
  });
}
