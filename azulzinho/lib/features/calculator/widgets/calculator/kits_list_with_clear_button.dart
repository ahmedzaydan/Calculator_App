import 'package:azulzinho/core/resources/strings_manager.dart';
import 'package:azulzinho/core/utils/dependency_injection.dart';
import 'package:azulzinho/core/widgets/collapse_button.dart';
import 'package:azulzinho/core/widgets/custom_elevated_button.dart';
import 'package:azulzinho/features/calculator/calculator_cubit/calculator_cubit.dart';
import 'package:azulzinho/themes/styles_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class KitsListWithClearButton extends StatelessWidget {
  KitsListWithClearButton({super.key});

  final cubit = locator<CalculatorCubit>();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // collapse button
        CollapseButton(
          onPressed: () {
            cubit.toggleKitsListVisibility();
          },
          isCollapsed: cubit.isKitsListCollapsed,
        ),

        Gap(30.h),

        // kits text
        Text(
          CalculatorStrings.kits,
          style: getBoldStyle().copyWith(
            fontSize: 24.sp,
          ),
        ),

        const Spacer(),

        // clear button
        CustomElevatedButton(
          height: 40,
          onPressed: () async {
            await cubit.clear();
          },
          text: CalculatorStrings.clear,
        ),
      ],
    );
  }
}
