import 'package:azulzinho/core/resources/constants_manager.dart';
import 'package:azulzinho/core/resources/strings_manager.dart';
import 'package:azulzinho/core/resources/values_manager.dart';
import 'package:azulzinho/core/utils/functions.dart';
import 'package:azulzinho/core/widgets/add_list_tile.dart';
import 'package:azulzinho/core/widgets/custom_alert_dialog.dart';
import 'package:azulzinho/core/widgets/custom_list_view.dart';
import 'package:azulzinho/core/widgets/item_widgets/data_item.dart';
import 'package:azulzinho/features/persons/models/person_model.dart';
import 'package:azulzinho/features/persons/person_cubit/persons_cubit.dart';
import 'package:azulzinho/features/persons/views/add_person_view.dart';
import 'package:azulzinho/features/persons/views/edit_person_view.dart';
import 'package:azulzinho/features/persons/widgets/admin_widget.dart';
import 'package:azulzinho/themes/color_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class PersonsViewBody extends StatelessWidget {
  const PersonsViewBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var cubit = PersonsCubit.of(context);

    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: AppPadding.p20.w,
          vertical: AppPadding.p20.h,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AdminWidget(),

            Gap(20.h),

            // add person inkwell
            AddListTile(
              text: PersonsStrings.addPerson,
              onTap: () {
                navigateTo(
                  context: context,
                  dest: AddPersonView(),
                );
              },
            ),

            Gap(isTablet ? 40.h : 60.h),

            CustomListView(
              itemBuilder: (context, index) {
                PersonModel person = cubit.personItems[index];
                return DataItem(
                  color: index % 2 == 0
                      ? ColorManager.white
                      : ColorManager.lightGrey2,
                  name: person.name,
                  value: '${person.percentage}%',
                  onActionPressed: () {
                    navigateTo(
                      context: context,
                      dest: EditPersonView(
                        person: person,
                        index: index,
                      ),
                    );
                  },
                  deleteOnPressed: () {
                    showCustomAlertDialog(
                      context: context,
                      message: PersonsStrings.deleteConfirmation,
                      onOk: () async {
                        await cubit.deletePerson(index);
                      },
                    );
                  },
                );
              },
              itemCount: cubit.personItems.length,
              separatorBuilder: (context, index) => Gap(20.h),
            ),
          ],
        ),
      ),
    );
  }
}
