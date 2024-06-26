import 'package:azulzinho/core/resources/strings_manager.dart';
import 'package:azulzinho/core/resources/values_manager.dart';
import 'package:azulzinho/core/utils/functions.dart';
import 'package:azulzinho/core/widgets/custom_list_tile.dart';
import 'package:azulzinho/features/persons/views/add_person_view.dart';
import 'package:azulzinho/features/persons/views/widgets/admin_widget.dart';
import 'package:azulzinho/features/persons/views/widgets/persons_list_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class PersonsViewBody extends StatelessWidget {
  const PersonsViewBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: AppPadding.p20.w,
          vertical: AppPadding.p20.h,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AdminWidget(sourceContext: context),

            Gap(20.h),

            // add person inkwell
            CustomListTile(
              text: PersonsStrings.addPerson,
              onTap: () {
                navigateTo(
                  context: context,
                  dest: AddPersonView(sourceContext: context),
                );
              },
            ),

            Gap(60.h),

            PersonsListView(sourceContext: context),
          ],
        ),
      ),
    );
  }
}
