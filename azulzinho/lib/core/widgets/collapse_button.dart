import 'package:azulzinho/core/resources/constants_manager.dart';
import 'package:azulzinho/core/widgets/custom_icon_button.dart';
import 'package:azulzinho/themes/color_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CollapseButton extends StatelessWidget {
  const CollapseButton({
    super.key,
    required this.onPressed,
    required this.isCollapsed,
  });

  final void Function()? onPressed;
  final bool isCollapsed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        right: 8.w,
      ),
      child: CustomIconButton(
        onPressed: onPressed,
        faIcon: FaIcon(
          isCollapsed
              ? FontAwesomeIcons.circleChevronDown
              : FontAwesomeIcons.circleChevronUp,
          color: ColorManager.iconColor,
          size: ConstantsManager.iconSize,
        ),
      ),
    );
  }
}
