import 'package:calculator/app/utils/dependency_injection.dart';
import 'package:calculator/app/utils/functions.dart';
import 'package:calculator/app/widgets/custom_list_view.dart';
import 'package:calculator/features/kits/kit_cubit/kit_cubit.dart';
import 'package:calculator/features/kits/models/kit_model.dart';
import 'package:calculator/features/kits/views/widgets/kit_widget.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class KitsListView extends StatelessWidget {
  KitsListView({super.key});

  final KitsCubit cubit = locator<KitsCubit>();

  @override
  Widget build(BuildContext context) {
    return CustomListView(
      itemBuilder: (context, index) {
        KitModel kit = cubit.kitItems[index];
        return KitWidget(
          kit: kit,
          editOnPressed: () {
            kprint("Navigate to edit screen");
               // return EditItemWidget(
            //   value: profit.value,
            //   name: profit.id,
            //   onChanged: (value) async {
            //     kprint(value.runtimeType);
            //     kprint(value);
            //     await cubit.updateKitValue(
            //       index: index,
            //       value: value,
            //     );
            //   },
            //   deleteOnPressed: () async => await cubit.deleteKitItem(index),
            // );
          },
          deleteOnPressed: () async => await cubit.deleteKitItem(index),
        );
      },
      itemCount: cubit.kitItems.length,
      separatorBuilder: (context, index) => const Gap(0),
    );
  }
}
