import 'package:calculator/app/resources/strings_manager.dart';
import 'package:calculator/app/utils/dependency_injection.dart';
import 'package:calculator/app/utils/functions.dart';
import 'package:calculator/app/widgets/custom_list_view.dart';
import 'package:calculator/features/kits/kit_cubit/kit_cubit.dart';
import 'package:calculator/features/kits/models/kit_model.dart';
import 'package:calculator/features/kits/views/widgets/kit_widget.dart';
import 'package:calculator/features/widgets/collapse_button.dart';
import 'package:calculator/features/widgets/edit_item_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
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
    return Column(
      children: [
        // expired
        KitsListWidget(
          sourceContext: sourceContext,
          list: cubit.expiredKitsItems,
          title: StringsManager.expired,
          collapseOnPressed: () => cubit.toggleExpiredListVisibility(),
          isCollapsed: cubit.isExpiredListCollapsed,
        ),

        const Gap(20),

        // month 30
        KitsListWidget(
          sourceContext: sourceContext,
          list: cubit.month30KitsItems,
          title: StringsManager.month30,
          collapseOnPressed: () => cubit.toggleMonth30ListVisibility(),
          isCollapsed: cubit.isMonth30ListCollapsed,
        ),

        const Gap(20),

        // month 24
        KitsListWidget(
          sourceContext: sourceContext,
          list: cubit.month24KitsItems,
          title: StringsManager.month24,
          collapseOnPressed: () => cubit.toggleMonth24ListVisibility(),
          isCollapsed: cubit.isMonth24ListCollapsed,
        ),

        const Gap(20),

        // month 12
        KitsListWidget(
          sourceContext: sourceContext,
          list: cubit.month12KitsItems,
          title: StringsManager.month12,
          collapseOnPressed: () => cubit.toggleMonth12ListVisibility(),
          isCollapsed: cubit.isMonth12ListCollapsed,
        ),

        const Gap(20),

        // transparent
        KitsListWidget(
          sourceContext: sourceContext,
          list: cubit.transparentKitsItems,
          title: StringsManager.emptyString,
          collapseOnPressed: () => cubit.toggleTransparentListVisibility(),
          isCollapsed: cubit.isTransperantListCollapsed,
        ),
      ],
    );
  }
}

class KitsListWidget extends StatelessWidget {
  KitsListWidget({
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
        Row(
          children: [
            CollapseButton(
              onPressed: collapseOnPressed,
              isCollapsed: isCollapsed,
            ),
            const Gap(15),
            Text(title),
          ],
        ),
        Visibility(
          visible: isCollapsed,
          child: CustomListView(
            itemBuilder: (_, index) {
              KitModel kit = list[index];
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
            itemCount: list.length,
            separatorBuilder: (context, index) => const Gap(10),
          ),
        ),
      ],
    );
  }
}
