import 'package:azulzinho/app/utils/dependency_injection.dart';
import 'package:azulzinho/app/widgets/custom_list_view.dart';
import 'package:azulzinho/features/kits/kit_cubit/kit_cubit.dart';
import 'package:azulzinho/features/kits/views/widgets/kits_list_widget.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class KitsListsView extends StatelessWidget {
  KitsListsView({
    super.key,
    required this.sourceContext,
  });

  final KitsCubit cubit = locator<KitsCubit>();
  final BuildContext sourceContext;

  @override
  Widget build(BuildContext context) {
    return CustomListView(
      itemBuilder: (context, index) {
        return KitsListsWidget(
          sourceContext: sourceContext,
          list: cubit.getCollapsableList(index),
          title: cubit.listsTitles[index],
          isCollapsed: cubit.collapsedLists[index],
          collapseOnPressed: () => cubit.toggleListVisibility(index),
        );
      },
      itemCount: 5,
      separatorBuilder: (_, __) => Gap(0),
    );
  }
}
