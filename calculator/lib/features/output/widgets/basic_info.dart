import 'package:calculator/app/resources/strings_manager.dart';
import 'package:calculator/app/utils/dependency_injection.dart';
import 'package:calculator/app/utils/functions.dart';
import 'package:calculator/features/home/calculator_cubit/calculator_cubit.dart';
import 'package:calculator/features/kits/kit_cubit/kit_cubit.dart';
import 'package:calculator/features/output/widgets/info_item.dart';
import 'package:flutter/material.dart';

class BasicInfo extends StatelessWidget {
  const BasicInfo({super.key});

  @override
  Widget build(BuildContext context) {
    var cubit = locator<CalculatorCubit>();
    var profitsCubit = locator<KitsCubit>();
    return Column(
      children: [
        // date
        InfoItem(
          label: StringsManager.date,
          value: getCurrentDate(),
        ),

        const Divider(),

        // total kit
        InfoItem(
          label: StringsManager.totalProfit,
          value: profitsCubit.totalKits.toString(),
        ),

        if (profitsCubit.checkedkits.isNotEmpty)
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              '(${profitsCubit.checkedkits})',
            ),
          ),

        const Divider(),

        // total expense
        InfoItem(
          label: StringsManager.totalExpense,
          value: cubit.totalExpense.toString(),
        ),

        const Divider(),

        // total extra
        InfoItem(
          label: StringsManager.extra,
          value: cubit.totalExtra.toString(),
        ),

        const Divider(),

        // net profit
        InfoItem(
          label: StringsManager.netProfit,
          value: cubit.netProfit.toString(),
        ),

        const Divider(),
      ],
    );
  }
}
