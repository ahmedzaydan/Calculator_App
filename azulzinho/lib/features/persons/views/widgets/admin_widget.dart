import 'package:azulzinho/app/resources/color_manager.dart';
import 'package:azulzinho/app/resources/constants_manager.dart';
import 'package:azulzinho/app/resources/strings_manager.dart';
import 'package:azulzinho/app/resources/styles_manager.dart';
import 'package:azulzinho/app/resources/values_manager.dart';
import 'package:azulzinho/app/utils/dependency_injection.dart';
import 'package:azulzinho/app/utils/functions.dart';
import 'package:azulzinho/app/widgets/data_item_actions_widget.dart';
import 'package:azulzinho/app/widgets/edit_item_view.dart';
import 'package:azulzinho/features/persons/person_cubit/persons_cubit.dart';
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
      padding: EdgeInsets.symmetric(
        vertical: AppPadding.p14.h,
        horizontal: AppPadding.p20.w,
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
                  style: TextStylesManager.textStyle26.copyWith(
                    color: ColorManager.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),

                // admin percentage
                Text(
                  '${locator<PersonsCubit>().admin.percentage}%',
                  style: TextStylesManager.textStyle26.copyWith(
                    color: ColorManager.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          Gap(15.h),
          Padding(
            padding: EdgeInsets.only(
              right: AppPadding.p10.w,
            ),
            child: DataItemActionsWidget(
              isDeleteVisible: false,
              editButtonStyle: ButtonStyle(
                iconColor: MaterialStateProperty.all(ColorManager.white),
                iconSize: MaterialStateProperty.all(AppSize.s28),
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
          ),
        ],
      ),
    );
  }
}
