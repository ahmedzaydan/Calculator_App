import 'package:azulzinho/core/resources/styles_manager.dart';
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
          style: TextStylesManager.textStyle26,
        ),
        Text(
          value,
          style: TextStylesManager.textStyle26,
        ),
      ],
    );
  }
}
