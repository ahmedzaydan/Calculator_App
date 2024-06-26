import 'package:azulzinho/core/resources/constants_manager.dart';
import 'package:azulzinho/core/resources/strings_manager.dart';
import 'package:azulzinho/core/resources/values_manager.dart';
import 'package:azulzinho/core/utils/dependency_injection.dart';
import 'package:azulzinho/core/utils/functions.dart';
import 'package:azulzinho/core/widgets/data_item_actions_widget.dart';
import 'package:azulzinho/core/widgets/edit_item_view.dart';
import 'package:azulzinho/features/persons/person_cubit/persons_cubit.dart';
import 'package:azulzinho/themes/color_manager.dart';
import 'package:azulzinho/themes/styles_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
        borderRadius: BorderRadius.circular(
          ConstantsManager.borderRadius,
        ),
      ),
      padding: EdgeInsets.only(
        top: AppPadding.p10.h,
        bottom: AppPadding.p10.h,
        right: AppPadding.p20.w,
        left: AppPadding.p10.w,
      ),
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
                  style: getBoldStyle(color: ColorManager.white),
                ),

                // admin percentage
                Text(
                  '${locator<PersonsCubit>().admin.percentage}%',
                  style: getBoldStyle(color: ColorManager.white),
                ),
              ],
            ),
          ),
          Gap(15.h),
          DataItemActionsWidget(
            isDeleteVisible: false,
            editButtonStyle: ButtonStyle(
              iconColor: MaterialStateProperty.all(ColorManager.white),
              iconSize: MaterialStateProperty.all(AppSize.s24),
            ),
            editOnPressed: () {
              navigateTo(
                context: sourceContext,
                dest: EditItemView(
                  label: PersonsStrings.admin,
                  value: locator<PersonsCubit>().admin.percentage,
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
