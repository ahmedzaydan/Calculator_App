import 'package:calculator/app/resources/values_manager.dart';
import 'package:calculator/app/utils/functions.dart';
import 'package:calculator/features/kits/models/kit_model.dart';
import 'package:calculator/features/widgets/actions_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class KitWidget extends StatelessWidget {
  const KitWidget({
    super.key,
    required this.kit,
    this.editOnPressed,
    this.deleteOnPressed,
  });

  final KitModel kit;
  final void Function()? editOnPressed;
  final void Function()? deleteOnPressed;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(right: AppPadding.p10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // kit name
                Text(
                  kit.id,
                  style: getTextStyle(),
                ),

                // kit value
                Text(
                  '${kit.value}',
                  style: getTextStyle(),
                ),
              ],
            ),
          ),
        ),

        // edit and delete buttons
        ActionsWidget(
          editOnPressed: editOnPressed,
          deleteOnPressed: deleteOnPressed,
        ),
      ],
    );
  }
}
