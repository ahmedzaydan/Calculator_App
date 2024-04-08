import 'package:calculator/app/utils/dependency_injection.dart';
import 'package:calculator/app/utils/functions.dart';
import 'package:calculator/app/widgets/custom_list_view.dart';
import 'package:calculator/features/kits/kit_cubit/kit_cubit.dart';
import 'package:calculator/features/kits/models/kit_model.dart';
import 'package:calculator/features/kits/views/widgets/kit_widget.dart';
import 'package:calculator/features/widgets/edit_item_view.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class KitsListView extends StatelessWidget {
  KitsListView({
    super.key,
    required this.sourceContext,
  });

  final KitsCubit cubit = locator<KitsCubit>();
  final BuildContext sourceContext;

  @override
  Widget build(BuildContext context) {
    return CustomListView(
      itemBuilder: (_, index) {
        KitModel kit = cubit.kitItems[index];
        return KitWidget(
          kit: kit,
          editOnPressed: () {
            navigateTo(
              context: sourceContext,
              dest: EditItemView(
                label: kit.name,
                value: kit.value,
                updateKits: true,
                sourceContext: sourceContext,
                index: index,
              ),
            );
          },
          deleteOnPressed: () async => await cubit.deleteKitItem(index),
        );
      },
      itemCount: cubit.kitItems.length,
      separatorBuilder: (context, index) => const Gap(10),
    );
  }
}
