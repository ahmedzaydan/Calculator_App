import 'package:calculator/core/calculator_cubit/calculator_cubit.dart';
import 'package:calculator/core/resources/strings_manager.dart';
import 'package:calculator/core/utils/functions.dart';
import 'package:calculator/views/output/widgets/info_item.dart';
import 'package:flutter/material.dart';

class BasicInfo extends StatelessWidget {
  const BasicInfo({super.key});

  @override
  Widget build(BuildContext context) {
    var cubit = CalculatorCubit.get(context);
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
          value: cubit.totalProfit.toString(),
        ),

        if (cubit.checkedProfits.isNotEmpty)
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              '(${cubit.checkedProfits})',
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
