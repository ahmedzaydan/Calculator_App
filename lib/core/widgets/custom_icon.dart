import 'package:azulzinho/core/utils/constants_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

// TODO: all icons in app should be used from this widget
class CustomIcon extends StatelessWidget {
  const CustomIcon({
    super.key,
    required this.icon,
    this.size = 24,
  });

  final IconData icon;
  final double size;

  @override
  Widget build(BuildContext context) {
    return FaIcon(
      icon,
      size: (size / (isTablet ? 1.5 : 1)).sp,
    );
  }
}
