import 'package:calculator/app/utils/dependency_injection.dart';
import 'package:calculator/app/utils/functions.dart';
import 'package:calculator/app/widgets/custom_list_view.dart';
import 'package:calculator/features/persons/models/person_model.dart';
import 'package:calculator/features/persons/person_cubit/persons_cubit.dart';
import 'package:calculator/features/persons/views/widgets/person_widget.dart';
import 'package:calculator/features/widgets/edit_item_view.dart';
import 'package:flutter/material.dart';
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
        return PersonWidget(
          person: person,
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
          deleteOnPressed: () async => await cubit.deletePerson(index),
        );
      },
      itemCount: cubit.personItems.length,
      separatorBuilder: (context, index) => const Gap(0),
    );
  }
}
