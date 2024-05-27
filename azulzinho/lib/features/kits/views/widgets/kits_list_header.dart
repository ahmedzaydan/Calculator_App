import 'package:azulzinho/themes/styles_manager.dart';
import 'package:azulzinho/core/widgets/collapse_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class KitsListHeader extends StatelessWidget {
  const KitsListHeader({
    super.key,
    required this.title,
    required this.counter,
    required this.collapseButton,
  });

  final String title;
  final String counter;
  final CollapseButton collapseButton;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // title
        Text(
          title,
          style: TextStylesManager.textStyle26.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),

        const Spacer(),

        // counter
        Text(
          counter,
          style: TextStylesManager.textStyle26.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),

        Gap(20.h),

        collapseButton,
      ],
    );
  }
}
