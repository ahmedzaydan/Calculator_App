import 'package:azulzinho/app/resources/color_manager.dart';
import 'package:azulzinho/app/resources/strings_manager.dart';
import 'package:azulzinho/app/widgets/custom_elevated_button.dart';
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
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(
                ColorManager.green,
              ),
            ),
            onPressed: onPressed,
            text: actionText,
          ),
        ),

        Gap(10.w),

        // cancel button
        Expanded(
          child: CustomElevatedButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(
                ColorManager.red2,
              ),
            ),
            onPressed: () => Navigator.pop(sourceContext),
            text: StringsManager.cancel,
          ),
        ),
      ],
    );
  }
}
