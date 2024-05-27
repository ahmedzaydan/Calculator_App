import 'package:azulzinho/core/resources/constants_manager.dart';
import 'package:azulzinho/core/resources/strings_manager.dart';
import 'package:azulzinho/themes/styles_manager.dart';
import 'package:azulzinho/core/resources/values_manager.dart';
import 'package:azulzinho/core/utils/functions.dart';
import 'package:azulzinho/features/calculator/calculator_cubit/calculator_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class Note extends StatelessWidget {
  const Note({super.key, required this.cubit});

  final CalculatorCubit cubit;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (cubit.note.isNotEmpty) ...[
          // note title
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              CalculatorStrings.note,
              style: TextStylesManager.textStyle26,
            ),
          ),

          Gap(10.h),

          // note body
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: AppPadding.p10.w,
              vertical: AppPadding.p10.h,
            ),
            width: double.infinity,
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.grey,
                width: 2.sp,
              ),
              borderRadius: BorderRadius.circular(
                ConstantsManager.borderRadius,
              ),
            ),
            child: Directionality(
              textDirection: getTextDirection(cubit.note),
              child: Text(
                cubit.note,
                style: TextStylesManager.textStyle26,
              ),
            ),
          ),
        ],
      ],
    );
  }
}
