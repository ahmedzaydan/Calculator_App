import 'package:calculator/app/utils/dependency_injection.dart';
import 'package:calculator/app/widgets/custom_list_view.dart';
import 'package:calculator/features/settings/profits/models/profit_model.dart';
import 'package:calculator/features/settings/profits/profit_cubit/profit_cubit.dart';
import 'package:calculator/features/settings/widgets/edit_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class ProfitsList extends StatelessWidget {
  ProfitsList({
    super.key,
  });

  final ProfitsCubit cubit = locator<ProfitsCubit>();

  @override
  Widget build(BuildContext context) {
    return CustomListView(
      itemBuilder: (context, index) {
        ProfitModel profit = cubit.profitItems[index];
        return EditItemWidget(
          value: profit.value,
          name: profit.id,
          onChanged: (value) async {
            await cubit.updateProfitValue(
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
