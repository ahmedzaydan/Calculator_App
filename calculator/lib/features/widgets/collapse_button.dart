import 'package:calculator/app/resources/color_manager.dart';
import 'package:calculator/app/widgets/custom_icon_button.dart';
import 'package:flutter/material.dart';
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
    return CustomIconButton(
      onPressed: onPressed,
      icon: FaIcon(
        isCollapsed
            ? FontAwesomeIcons.circleChevronDown
            : FontAwesomeIcons.circleChevronUp,
        color: ColorManager.primary,
      ),
    );
  }
}
