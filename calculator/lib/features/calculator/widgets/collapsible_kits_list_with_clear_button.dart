import 'package:calculator/app/resources/color_manager.dart';
import 'package:calculator/app/resources/strings_manager.dart';
import 'package:calculator/app/resources/styles_manager.dart';
import 'package:calculator/app/utils/dependency_injection.dart';
import 'package:calculator/app/widgets/custom_elevated_button.dart';
import 'package:calculator/app/widgets/custom_icon_button.dart';
import 'package:calculator/features/calculator/calculator_cubit/calculator_cubit.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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
          CustomIconButton(
            onPressed: () => cubit.toggleKitsListVisibility(),
            icon: FaIcon(
              cubit.isKitsListCollapsed
                  ? FontAwesomeIcons.circleChevronDown
                  : FontAwesomeIcons.circleChevronUp,
              color: ColorManager.primary,
            ),
          ),

          const Gap(15),

          // kits text
          Text(
            StringsManager.kits,
            style: TextStylesManager.textStyle20.copyWith(
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
