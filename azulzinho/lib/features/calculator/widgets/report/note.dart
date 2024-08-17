import 'package:azulzinho/core/resources/constants_manager.dart';
import 'package:azulzinho/core/resources/strings_manager.dart';
import 'package:azulzinho/core/resources/values_manager.dart';
import 'package:azulzinho/core/utils/functions.dart';
import 'package:azulzinho/themes/color_manager.dart';
import 'package:azulzinho/themes/styles_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class Note extends StatelessWidget {
  const Note({
    super.key,
    required this.note,
  });

  final String note;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (note.isNotEmpty) ...[
          // note title
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              CalculatorStrings.note,
              style: getBoldStyle(),
            ),
          ),

          Gap(10.h),

          // note body
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: AppPadding.p10.w,
              vertical: AppPadding.p10.h,
            ),
            width: 1.sw,
            decoration: BoxDecoration(
              border: Border.all(
                color: ColorManager.lightGrey2,
                width: 2.sp,
              ),
              borderRadius: BorderRadius.circular(
                ConstantsManager.borderRadius,
              ),
            ),
            child: Directionality(
              textDirection: getTextDirection(note),
              child: Text(
                note,
                style: getMediumStyle(),
              ),
            ),
          ),
        ],
      ],
    );
  }
}
