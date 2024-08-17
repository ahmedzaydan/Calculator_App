import 'package:azulzinho/themes/strings_manager.dart';
import 'package:azulzinho/core/utils/dependency_injection.dart';
import 'package:azulzinho/core/widgets/collapse_button.dart';
import 'package:azulzinho/core/widgets/custom_elevated_button.dart';
import 'package:azulzinho/core/widgets/custom_expansion_tile.dart';
import 'package:azulzinho/core/widgets/custom_list_view.dart';
import 'package:azulzinho/features/calculator/calculator_cubit/calculator_cubit.dart';
import 'package:azulzinho/features/calculator/widgets/calculator/kit_with_checkbox.dart';
import 'package:azulzinho/features/kits/kit_cubit/kit_cubit.dart';
import 'package:azulzinho/features/kits/models/kit_model.dart';
import 'package:azulzinho/themes/styles_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class KitsListWithClearButton extends StatelessWidget {
  KitsListWithClearButton({super.key});

  @override
  Widget build(BuildContext context) {
    var calculatorCubit = locator<CalculatorCubit>();
    var kitsCubit = locator<KitsCubit>();

    return CustomExpansionTile(
      title: Text(
        CalculatorStrings.kits,
        style: getBoldStyle(fontSize: 24.sp),
      ),
      children: [
        CustomListView(
          itemBuilder: (_, index) {
            KitModel kit = kitsCubit.kits[index];
            return KitWithCheckbox(kit: kit);
          },
          separatorBuilder: (_, index) => Gap(5.h),
          itemCount: kitsCubit.kits.length,
        )
      ],
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          CollapseButton(
            isCollapsed: calculatorCubit.isKitsListCollapsed,
          ),

          // clear button
          CustomElevatedButton(
            height: 40,
            padding: EdgeInsets.symmetric(
              horizontal: 15.w,
              vertical: 5.h,
            ),
            onPressed: () async {
              await calculatorCubit.clear();
            },
            text: CalculatorStrings.clear,
          ),
        ],
      ),
    );
  }
}
