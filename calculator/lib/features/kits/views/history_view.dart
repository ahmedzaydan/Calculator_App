import 'package:calculator/app/resources/color_manager.dart';
import 'package:calculator/app/resources/font_manager.dart';
import 'package:calculator/app/resources/strings_manager.dart';
import 'package:calculator/app/resources/values_manager.dart';
import 'package:calculator/app/utils/dependency_injection.dart';
import 'package:calculator/app/widgets/custom_list_view.dart';
import 'package:calculator/app/widgets/data_item.dart';
import 'package:calculator/features/app_layout/app_layout_cubit/app_states.dart';
import 'package:calculator/features/kits/kit_cubit/kit_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class HistoryView extends StatelessWidget {
  HistoryView({super.key});

  final cubit = locator<KitsCubit>();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<KitsCubit, AppStates>(
      builder: (context, state) {
        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(AppPadding.p20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title
                const Text(
                  KitsStrings.historyTitle,
                  style: TextStyle(
                    fontSize: FontSize.s28,
                    fontWeight: FontWeight.bold,
                  ),
                  // style: FontManager.titleStyle,
                ),

                const Gap(40),

                CustomListView(
                  itemBuilder: (context, index) {
                    return DataItem(
                      color: ColorManager.expired,
                      name: cubit.expiredKits[index].name,
                      value: cubit.expiredKits[index].value.toString(),
                      isEditVisible: false,
                      isDeleteVisible: false,
                    );
                  },
                  itemCount: cubit.expiredKits.length,
                  separatorBuilder: (context, index) => const Gap(20),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
