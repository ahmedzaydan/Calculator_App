import 'package:azulzinho/app/resources/color_manager.dart';
import 'package:azulzinho/app/resources/strings_manager.dart';
import 'package:azulzinho/app/resources/styles_manager.dart';
import 'package:azulzinho/app/resources/values_manager.dart';
import 'package:azulzinho/app/utils/dependency_injection.dart';
import 'package:azulzinho/app/utils/functions.dart';
import 'package:azulzinho/app/widgets/data_item_actions_widget.dart';
import 'package:azulzinho/app/widgets/edit_item_view.dart';
import 'package:azulzinho/features/persons/person_cubit/persons_cubit.dart';
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
        color: ColorManager.primary,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: ColorManager.black,
          width: 1.3,
        ),
      ),
      padding: const EdgeInsets.all(AppPadding.p20),
      margin: const EdgeInsets.symmetric(horizontal: AppMargin.m4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // admin text
                Text(
                  PersonsStrings.admin,
                  style: TextStylesManager.textStyle28.copyWith(
                    color: ColorManager.white,
                  ),
                ),

                // admin percentage
                Text(
                  '${locator<PersonsCubit>().adminPercentage}%',
                  style: TextStyle(
                    color: ColorManager.white,
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          const Gap(15),
          Padding(
            padding: const EdgeInsets.only(
              right: AppPadding.p10,
            ),
            child: DataItemActionsWidget(
              isDeleteVisible: false,
              editButtonStyle: ButtonStyle(
                iconColor: MaterialStateProperty.all(ColorManager.white),
              ),
              editOnPressed: () {
                navigateTo(
                  context: sourceContext,
                  dest: EditItemView(
                    label: PersonsStrings.admin,
                    value: locator<PersonsCubit>().adminPercentage,
                    sourceContext: sourceContext,
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}