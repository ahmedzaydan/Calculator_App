import 'package:calculator/app/resources/color_manager.dart';
import 'package:calculator/app/widgets/custom_icon_button.dart';
import 'package:flutter/material.dart';

class ActionsWidget extends StatelessWidget {
  const ActionsWidget({
    super.key,
    this.editOnPressed,
    this.deleteOnPressed,
  });

  final void Function()? editOnPressed;
  final void Function()? deleteOnPressed;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // edit button
        CustomIconButton(
          onPressed: editOnPressed,
          icon: const Icon(Icons.edit),
        ),

        // delete button
        CustomIconButton(
          onPressed: deleteOnPressed,
          icon: const Icon(Icons.delete),
          style: ButtonStyle(
            backgroundColor:
                MaterialStateProperty.all(ColorManager.transparent),
            iconColor: MaterialStateProperty.all(ColorManager.red),
          ),
        ),
      ],
    );
  }
}
