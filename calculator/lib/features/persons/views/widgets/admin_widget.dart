import 'package:calculator/app/resources/strings_manager.dart';
import 'package:calculator/app/resources/values_manager.dart';
import 'package:calculator/app/utils/dependency_injection.dart';
import 'package:calculator/app/utils/functions.dart';
import 'package:calculator/features/persons/person_cubit/persons_cubit.dart';
import 'package:calculator/features/widgets/actions_widget.dart';
import 'package:calculator/features/widgets/edit_item_view.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class AdminWidget extends StatelessWidget {
  const AdminWidget({
    super.key,
    required this.sourceContext,
  });

  final BuildContext sourceContext;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[400],
        borderRadius: BorderRadius.circular(10),
      ),
      padding: const EdgeInsets.all(AppPadding.p16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // admin text
                Text(
                  StringsManager.admin,
                  style: getTextStyle(),
                ),

                // admin percentage
                Text(
                  '${locator<PersonsCubit>().adminPercentage}%',
                  style: getTextStyle(),
                ),
              ],
            ),
          ),
          const Gap(15),
          ActionsWidget(
            isDeleteVisible: false,
            editOnPressed: () {
              navigateTo(
                context: sourceContext,
                dest: EditItemView(
                  label: StringsManager.admin,
                  value: locator<PersonsCubit>().adminPercentage,
                  sourceContext: sourceContext,
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
