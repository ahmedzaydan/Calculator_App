import 'package:calculator/app/resources/font_manager.dart';
import 'package:calculator/app/resources/strings_manager.dart';
import 'package:calculator/app/resources/values_manager.dart';
import 'package:calculator/app/utils/dependency_injection.dart';
import 'package:calculator/app/utils/functions.dart';
import 'package:calculator/app/widgets/custom_divider.dart';
import 'package:calculator/features/calculator/calculator_cubit/calculator_cubit.dart';
import 'package:calculator/features/calculator/widgets/info_item.dart';
import 'package:calculator/features/kits/kit_cubit/kit_cubit.dart';
import 'package:flutter/material.dart';

class BasicInfo extends StatelessWidget {
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
          value: getCurrentDateAsString(),
        ),

        _reportDivider(),

        // total kit
        InfoItem(
          label: CalculatorStrings.totalProfit,
          value: kitsCubit.totalKits.toString(),
        ),

        if (kitsCubit.checkedKits.isNotEmpty)
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              '(${kitsCubit.checkedKits})',
              style: const TextStyle(
                fontSize: FontSize.s18,
              ),
            ),
          ),

        _reportDivider(),

        // total expense
        InfoItem(
          label: CalculatorStrings.totalExpense,
          value: cubit.totalExpense.toString(),
        ),

        _reportDivider(),

        // total extra
        InfoItem(
          label: CalculatorStrings.extra,
          value: cubit.totalExtra.toString(),
        ),

        _reportDivider(),

        // net profit
        InfoItem(
          label: CalculatorStrings.netProfit,
          value: cubit.netProfit.toString(),
        ),

        _reportDivider(),
      ],
    );
  }

  Widget _reportDivider() => const Padding(
        padding: EdgeInsets.symmetric(vertical: AppPadding.p8),
        child: CustomDivider(),
      );
}
