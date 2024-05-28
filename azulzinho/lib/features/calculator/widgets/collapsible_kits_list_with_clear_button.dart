import 'package:azulzinho/core/resources/strings_manager.dart';
import 'package:azulzinho/core/utils/dependency_injection.dart';
import 'package:azulzinho/core/widgets/collapse_button.dart';
import 'package:azulzinho/core/widgets/custom_elevated_button.dart';
import 'package:azulzinho/features/calculator/calculator_cubit/calculator_cubit.dart';
import 'package:azulzinho/themes/styles_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class CollapsibleKitsListWithClearButton extends StatelessWidget {
  CollapsibleKitsListWithClearButton({super.key, required this.clearOnPressed});

  final cubit = locator<CalculatorCubit>();
  final void Function()? clearOnPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 0.02.sw),
      child: Row(
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
            style: getBoldStyle(),
          ),

          const Spacer(),

          // clear button
          CustomElevatedButton(
            height: 40,
            onPressed: clearOnPressed,
            text: CalculatorStrings.clear,
          ),
        ],
      ),
    );
  }
}
