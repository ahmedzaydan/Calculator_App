import 'package:azulzinho/core/resources/strings_manager.dart';
import 'package:azulzinho/core/resources/values_manager.dart';
import 'package:azulzinho/core/utils/dependency_injection.dart';
import 'package:azulzinho/core/utils/functions.dart';
import 'package:azulzinho/features/calculator/calculator_cubit/calculator_cubit.dart';
import 'package:azulzinho/features/calculator/widgets/report/info_item.dart';
import 'package:azulzinho/features/kits/kit_cubit/kit_cubit.dart';
import 'package:azulzinho/themes/styles_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
          value: getDateAsString(),
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
              style: getRegularStyle(),
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

  Widget _reportDivider() => Padding(
        padding: EdgeInsets.symmetric(vertical: AppPadding.p8.h),
        child: Divider(),
      );
}
