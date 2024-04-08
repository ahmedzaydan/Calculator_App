import 'package:calculator/app/widgets/custom_icon_button.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';

class ActionsWidget extends StatelessWidget {
  const ActionsWidget({
    super.key,
    this.editOnPressed,
    this.deleteOnPressed,
    this.isEditVisible = true,
    this.isDeleteVisible = true,
    this.editButtonStyle,
    this.deleteButtonStyle,
  });

  final void Function()? editOnPressed;
  final void Function()? deleteOnPressed;
  final bool isEditVisible;
  final bool isDeleteVisible;

  final ButtonStyle? editButtonStyle;
  final ButtonStyle? deleteButtonStyle;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // edit button
        if (isEditVisible)
          CustomIconButton(
            onPressed: editOnPressed,
            icon: const FaIcon(FontAwesomeIcons.penToSquare),
            style: editButtonStyle ?? Theme.of(context).iconButtonTheme.style,
          ),

        if (isDeleteVisible) ...[
          const Gap(15),

          // delete button
          CustomIconButton(
            onPressed: deleteOnPressed,
            icon: const FaIcon(FontAwesomeIcons.trashCan),
            style: deleteButtonStyle ?? Theme.of(context).iconButtonTheme.style,
          ),
        ]
      ],
    );
  }
}
