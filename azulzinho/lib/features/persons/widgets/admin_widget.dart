import 'package:azulzinho/themes/strings_manager.dart';
import 'package:azulzinho/core/utils/dependency_injection.dart';
import 'package:azulzinho/core/utils/functions.dart';
import 'package:azulzinho/core/widgets/custom_icon_button.dart';
import 'package:azulzinho/features/persons/cubit/persons_cubit.dart';
import 'package:azulzinho/features/persons/views/edit_person_view.dart';
import 'package:azulzinho/themes/color_manager.dart';
import 'package:azulzinho/themes/styles_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';

class AdminWidget extends StatelessWidget {
  const AdminWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      tileColor: ColorManager.primary,
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Admin percentage
          Text(
            '${locator<PersonsCubit>().admin.percentage}%',
            style: getBoldStyle(
              color: ColorManager.white,
            ),
          ),

          Gap(15.w),

          // Edit button
          CustomIconButton(
            onPressed: () {
              navigateTo(
                context: context,
                dest: EditPersonView(
                  person: locator<PersonsCubit>().admin,
                ),
              );
            },
            faIcon: FaIcon(
              FontAwesomeIcons.pen,
              size: 20.sp,
            ),
            style: ButtonStyle(
              iconColor: WidgetStateProperty.all(ColorManager.white),
              iconSize: WidgetStateProperty.all(24.sp),
            ),
          ),
        ],
      ),
      title: Text(
        PersonsStrings.admin,
      ),
    );
  }
}
