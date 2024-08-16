import 'package:azulzinho/core/resources/strings_manager.dart';
import 'package:azulzinho/core/utils/dependency_injection.dart';
import 'package:azulzinho/core/utils/extensions.dart';
import 'package:azulzinho/core/utils/functions.dart';
import 'package:azulzinho/core/widgets/custom_divider.dart';
import 'package:azulzinho/features/calculator/calculator_cubit/calculator_cubit.dart';
import 'package:azulzinho/core/widgets/item_widgets/info_item.dart';
import 'package:azulzinho/features/kits/kit_cubit/kit_cubit.dart';
import 'package:azulzinho/themes/color_manager.dart';
import 'package:azulzinho/themes/styles_manager.dart';
import 'package:flutter/material.dart';

class BasicInfo extends StatelessWidget {
  /// Date, total profit, total expense, total extra, net profit
  const BasicInfo({super.key});

  @override
  Widget build(BuildContext context) {
    var cubit = locator<CalculatorCubit>();
    var kitsCubit = locator<KitsCubit>();

    return Column(
      children: [
        // date
        InfoItem(
          label: CalculatorStrings.date,
          value: getDateAsString(),
        ),

        CustomDivider(),

        // total kit
        InfoItem(
          label: CalculatorStrings.totalProfit,
          value: kitsCubit.totalKits.toString().currency,
        ),

        if (kitsCubit.checkedKits.isNotEmpty)
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              '(${kitsCubit.checkedKits})',
              style: getRegularStyle(),
            ),
          ),

        CustomDivider(),

        // total expense
        InfoItem(
          label: CalculatorStrings.totalExpense,
          value: cubit.totalExpense.toString().currency,
          valueColor: ColorManager.red,
          labelColor: ColorManager.red,
        ),

        CustomDivider(),

        // total extra
        InfoItem(
          label: CalculatorStrings.extra,
          value: cubit.totalExtra.toString().currency,
        ),

        CustomDivider(),

        // net profit
        InfoItem(
          label: CalculatorStrings.netProfit,
          value: cubit.netProfit.toString().currency,
        ),

        CustomDivider(),
      ],
    );
  }
}
