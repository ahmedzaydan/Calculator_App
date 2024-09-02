import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomPadding extends StatelessWidget {
  const CustomPadding({
    super.key,
    this.horizontal = 20,
    this.vertical = 15,
    required this.child,
  });

  final double horizontal;
  final double vertical;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: horizontal.w,
        vertical: vertical.h,
      ),
      child: child,
    );
  }
}
