import 'package:calculator/app/resources/font_manager.dart';
import 'package:calculator/app/resources/strings_manager.dart';
import 'package:calculator/app/utils/dependency_injection.dart';
import 'package:calculator/app/widgets/custom_elevated_button.dart';
import 'package:calculator/features/calculator/calculator_cubit/calculator_cubit.dart';
import 'package:calculator/app/widgets/collapse_button.dart';
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
          const Text(
            StringsManager.kits,
            style: TextStyle(
              fontSize: FontSize.s28,
              fontWeight: FontWeight.bold,
            ),
          ),

          const Spacer(),

          // clera button
          SizedBox(
            height: MediaQuery.of(context).size.width * 0.12,
            child: CustomElevatedButton(
              onPressed: clearOnPressed,
              text: StringsManager.clear,
            ),
          ),
        ],
      ),
    );
  }
}
