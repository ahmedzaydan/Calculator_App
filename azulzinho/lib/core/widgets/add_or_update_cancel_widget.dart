import 'package:azulzinho/core/resources/strings_manager.dart';
import 'package:azulzinho/core/widgets/custom_elevated_button.dart';
import 'package:azulzinho/themes/color_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class ItemActionButtons extends StatelessWidget {
  const ItemActionButtons({
    super.key,
    required this.onActionPressed,
    required this.actionText,
  });

  final void Function()? onActionPressed;
  final String actionText;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // add/update button
        Expanded(
          child: CustomElevatedButton(
            backgroundColor: ColorManager.lightGreen,
            onPressed: onActionPressed,
            text: actionText,
          ),
        ),

        Gap(10.w),

        // cancel button
        Expanded(
          child: CustomElevatedButton(
            backgroundColor: ColorManager.red,
            onPressed: () => Navigator.pop(context),
            text: StringsManager.cancel,
          ),
        ),
      ],
    );
  }
}
