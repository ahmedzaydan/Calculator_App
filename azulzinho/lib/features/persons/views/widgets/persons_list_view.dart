import 'package:azulzinho/core/resources/strings_manager.dart';
import 'package:azulzinho/core/utils/dependency_injection.dart';
import 'package:azulzinho/core/utils/functions.dart';
import 'package:azulzinho/core/widgets/custom_list_view.dart';
import 'package:azulzinho/core/widgets/data_item.dart';
import 'package:azulzinho/core/widgets/edit_item_view.dart';
import 'package:azulzinho/features/persons/models/person_model.dart';
import 'package:azulzinho/features/persons/person_cubit/persons_cubit.dart';
import 'package:azulzinho/themes/color_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class PersonsListView extends StatelessWidget {
  PersonsListView({
    super.key,
    required this.sourceContext,
  });

  final PersonsCubit cubit = locator<PersonsCubit>();
  final BuildContext sourceContext;

  @override
  Widget build(BuildContext context) {
    return CustomListView(
      itemBuilder: (context, index) {
        PersonModel person = cubit.personItems[index];
        return DataItem(
            color: index % 2 == 0
                ? ColorManager.transparent
                : ColorManager.lightGrey2,
            name: person.name,
            value: '${person.percentage}%',
            editOnPressed: () {
              navigateTo(
                context: context,
                dest: EditItemView(
                  label: person.name,
                  value: person.percentage,
                  sourceContext: sourceContext,
                  index: index,
                ),
              );
            },
            deleteOnPressed: () {
              showCustomDialog(
                context: context,
                message: PersonsStrings.deleteConfirmation,
                onOk: () async {
                  await cubit.deletePerson(index);
                },
              );
            });
      },
      itemCount: cubit.personItems.length,
      separatorBuilder: (context, index) => Gap(20.h),
    );
  }
}
