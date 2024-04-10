import 'package:calculator/app/utils/dependency_injection.dart';
import 'package:calculator/app/utils/extensions.dart';
import 'package:calculator/app/utils/functions.dart';
import 'package:calculator/app/widgets/collapse_button.dart';
import 'package:calculator/app/widgets/custom_list_view.dart';
import 'package:calculator/app/widgets/data_item.dart';
import 'package:calculator/app/widgets/edit_item_view.dart';
import 'package:calculator/features/kits/kit_cubit/kit_cubit.dart';
import 'package:calculator/features/kits/models/kit_model.dart';
import 'package:calculator/features/kits/views/widgets/kits_list_header.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class KitsListsWidget extends StatelessWidget {
  KitsListsWidget({
    super.key,
    required this.sourceContext,
    required this.list,
    required this.title,
    this.collapseOnPressed,
    this.isCollapsed = false,
  });

  final KitsCubit cubit = locator<KitsCubit>();
  final BuildContext sourceContext;
  final List<KitModel> list;
  final String title;
  final void Function()? collapseOnPressed;
  final bool isCollapsed;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 10),
          child: KitsListHeader(
            title: title,
            counter: list.length.toString(),
            collapseButton: CollapseButton(
              isCollapsed: isCollapsed,
              onPressed: collapseOnPressed,
            ),
          ),
        ),
        const Gap(20),
        Visibility(
          visible: !isCollapsed,
          child: CustomListView(
            itemBuilder: (_, index) {
              KitModel kit = list[index];
              return DataItem(
                color: kit.status!.kitType.backgroundColor,
                name: kit.name,
                value: kit.value.toString(),
                editOnPressed: () {
                  navigateTo(
                    context: sourceContext,
                    dest: EditItemView(
                      kitModel: kit,
                      label: kit.name,
                      value: kit.value,
                      updateKits: true,
                      sourceContext: sourceContext,
                      index: index,
                    ),
                  );
                },
                deleteOnPressed: () async {
                  showCustomDialog(
                    context: context,
                    message: 'Are you sure you want to delete this kit?',
                    onOk: () async {
                      await cubit.deleteKit(kit);
                    },
                  );
                },
              );
            },
            itemCount: list.length,
            separatorBuilder: (context, index) => const Gap(10),
          ),
        ),
        isCollapsed ? const Gap(0) : const Gap(50),
      ],
    );
  }
}
