import 'package:calculator/app/utils/dependency_injection.dart';
import 'package:calculator/app/widgets/custom_list_view.dart';
import 'package:calculator/features/kits/kit_cubit/kit_cubit.dart';
import 'package:calculator/features/kits/views/widgets/kits_list_widget.dart';
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
      itemBuilder: (context, index) {
        return KitsListWidget(
          sourceContext: sourceContext,
          list: cubit.getCollapsableList(index),
          title: cubit.listsTitles[index],
          isCollapsed: cubit.collapsedLists[index],
          collapseOnPressed: () => cubit.toggleListVisibility(index),
        );
      },
      itemCount: cubit.collapsedLists.length,
      separatorBuilder: (_, __) => const Gap(0),
    );
  }
}
