import 'package:azulzinho/app/resources/strings_manager.dart';
import 'package:azulzinho/app/resources/values_manager.dart';
import 'package:azulzinho/app/utils/functions.dart';
import 'package:azulzinho/app/widgets/add_item_widget.dart';
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
            // admin widget
            AdminWidget(sourceContext: context),

             Gap(20.h),

            // add person inkwell
            AddItemWidget(
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
