import 'package:calculator/app/resources/color_manager.dart';
import 'package:flutter/material.dart';

class CustomDivider extends StatelessWidget {
  const CustomDivider({
    super.key,
    this.color,
    this.thickness = 2.1,
  });

  final Color? color;
  final double thickness;

  @override
  Widget build(BuildContext context) {
    return Divider(
      thickness: thickness,
      color: color ?? ColorManager.primary,
    );
  }
}
