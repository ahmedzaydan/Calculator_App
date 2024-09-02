import 'package:azulzinho/themes/strings_manager.dart';
import 'package:azulzinho/core/widgets/custom_app_bar.dart';
import 'package:azulzinho/core/widgets/custom_elevated_button.dart';
import 'package:azulzinho/core/widgets/custom_padding.dart';
import 'package:azulzinho/themes/color_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class ActionViewLayout extends StatelessWidget {
  const ActionViewLayout({
    super.key,
    required this.title,
    this.child,
    required this.onActionPressed,
    required this.actionText,
  });

  final String title;
  final Widget? child;

  final void Function()? onActionPressed;
  final String actionText;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: title),
      body: SingleChildScrollView(
        child: CustomPadding(
          child: Column(
            children: [
              if (child != null) ...[
                child!,
                Gap(20.h),
              ],

              // Action buttons
              Row(
                children: [
                  // Action button
                  Expanded(
                    child: CustomElevatedButton(
                      backgroundColor: ColorManager.lightGreen,
                      onPressed: onActionPressed,
                      text: actionText,
                    ),
                  ),

                  Gap(10.w),

                  // Cancel button
                  Expanded(
                    child: CustomElevatedButton(
                      backgroundColor: ColorManager.red,
                      onPressed: () => Navigator.pop(context),
                      text: StringsManager.cancel,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
