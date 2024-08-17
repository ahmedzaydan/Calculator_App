import 'package:azulzinho/core/utils/constants_manager.dart';
import 'package:azulzinho/themes/color_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CollapseButton extends StatelessWidget {
  const CollapseButton({
    super.key,
    required this.isCollapsed,
  });

  final bool isCollapsed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        right: 8.w,
      ),
      child: FaIcon(
        isCollapsed
            ? FontAwesomeIcons.circleChevronDown
            : FontAwesomeIcons.circleChevronUp,
        color: ColorManager.iconColor,
        size: ConstantsManager.iconSize,
      ),
    );
  }
}
