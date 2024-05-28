import 'package:azulzinho/themes/styles_manager.dart';
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
          style: getBoldStyle(),
        ),
        Text(
          value,
          style: getBoldStyle(),
        ),
      ],
    );
  }
}
