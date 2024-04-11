import 'package:calculator/app/resources/font_manager.dart';
import 'package:calculator/app/utils/functions.dart';
import 'package:flutter/material.dart';

class InfoItem extends StatelessWidget {
  const InfoItem({super.key, required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: getTextStyle(fontSize: FontSize.s24),
        ),
        Text(
          value,
          style: getTextStyle(fontSize: FontSize.s24),
        ),
      ],
    );
  }
}
