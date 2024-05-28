import 'package:azulzinho/core/resources/strings_manager.dart';
import 'package:azulzinho/core/widgets/custom_elevated_button.dart';
import 'package:azulzinho/themes/color_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class AddUpdateCancelWidget extends StatelessWidget {
  const AddUpdateCancelWidget({
    super.key,
    required this.onPressed,
    required this.actionText,
    required this.sourceContext,
  });

  final void Function()? onPressed;
  final String actionText;
  final BuildContext sourceContext;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // add/update button
        Expanded(
          child: CustomElevatedButton(
            backgroundColor: ColorManager.green,
            onPressed: onPressed,
            text: actionText,
          ),
        ),

        Gap(10.w),

        // cancel button
        Expanded(
          child: CustomElevatedButton(
            backgroundColor: ColorManager.red,
            onPressed: () => Navigator.pop(sourceContext),
            text: StringsManager.cancel,
          ),
        ),
      ],
    );
  }
}
