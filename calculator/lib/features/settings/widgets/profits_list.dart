import 'package:calculator/core/calculator_cubit/calculator_cubit.dart';
import 'package:calculator/core/models/profit_model.dart';
import 'package:calculator/core/widgets/custom_list_view.dart';
import 'package:calculator/features/settings/widgets/edit_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class ProfitsList extends StatelessWidget {
  const ProfitsList({
    super.key,
    required this.cubit,
  });

  final CalculatorCubit cubit;

  @override
  Widget build(BuildContext context) {
    return CustomListView(
      itemBuilder: (context, index) {
        ProfitModel profit = cubit.profitItems[index];
        return EditItemWidget(
          value: profit.value,
          name: 'Kit ${profit.id.substring(1)}',
          onChanged: (value) async {
            await cubit.editProfitValue(
              index: index,
              value: value,
            );
          },
          deleteOnPressed: () async => await cubit.deleteProfitItem(index),
        );
      },
      itemCount: cubit.profitItems.length,
      separatorBuilder: (context, index) => const Gap(25),
    );
  }
}
