import 'package:azulzinho/app/resources/strings_manager.dart';
import 'package:azulzinho/app/resources/styles_manager.dart';
import 'package:azulzinho/app/utils/dependency_injection.dart';
import 'package:azulzinho/app/widgets/collapse_button.dart';
import 'package:azulzinho/app/widgets/custom_elevated_button.dart';
import 'package:azulzinho/features/calculator/calculator_cubit/calculator_cubit.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class CollapsibleKitsListWithClearButton extends StatelessWidget {
  CollapsibleKitsListWithClearButton({super.key, required this.clearOnPressed});

  final cubit = locator<CalculatorCubit>();
  final void Function()? clearOnPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: MediaQuery.of(context).size.width * 0.02,
      ),
      child: Row(
        children: [
          // collapse button
          CollapseButton(
            onPressed: () {
              cubit.toggleKitsListVisibility();
            },
            isCollapsed: cubit.isKitsListCollapsed,
          ),

          const Gap(30),

          // kits text
          Text(
            CalculatorStrings.kits,
            style: TextStylesManager.textStyle28.copyWith(
              fontWeight: FontWeight.w500,
            ),
          ),

          const Spacer(),

          // clera button
          CustomElevatedButton(
            onPressed: clearOnPressed,
            text: CalculatorStrings.clear,
          ),
        ],
      ),
    );
  }
}
