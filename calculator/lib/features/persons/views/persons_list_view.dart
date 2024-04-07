import 'package:calculator/app/utils/dependency_injection.dart';
import 'package:calculator/app/widgets/custom_list_view.dart';
import 'package:calculator/features/persons/models/person_model.dart';
import 'package:calculator/features/persons/person_cubit/persons_cubit.dart';
import 'package:calculator/features/settings/widgets/edit_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class PersonsListView extends StatelessWidget {
  PersonsListView({
    super.key,
  });

  final PersonsCubit cubit = locator<PersonsCubit>();

  @override
  Widget build(BuildContext context) {
    return CustomListView(
      itemBuilder: (context, index) {
        PersonModel person = cubit.personItems[index];
        return EditItemWidget(
          value: person.percentage,
          name: person.name,
          onChanged: (value) {
            cubit.updatePersonPercentage(
              index: index,
              value: value,
            );
          },
          deleteOnPressed: () async => await cubit.deletePerson(index),
        );
      },
      itemCount: cubit.personItems.length,
      separatorBuilder: (context, index) => const Gap(25),
    );
  }
}
