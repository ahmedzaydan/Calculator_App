import 'package:flutter/material.dart';

class CustomDivider extends StatelessWidget {
  const CustomDivider({super.key, this.color,});

  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Divider(
      thickness: 2.1,
      color: color ?? Theme.of(context).dividerColor,
    );
  }
}
