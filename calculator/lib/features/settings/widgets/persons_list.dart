import 'package:calculator/core/calculator_cubit/calculator_cubit.dart';
import 'package:calculator/core/models/person_model.dart';
import 'package:calculator/core/widgets/custom_list_view.dart';
import 'package:calculator/features/settings/widgets/edit_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class PersonsList extends StatelessWidget {
  const PersonsList({
    super.key,
    required this.cubit,
  });

  final CalculatorCubit cubit;

  @override
  Widget build(BuildContext context) {
    return CustomListView(
      itemBuilder: (context, index) {
        PersonModel person = cubit.personItems[index];
        return EditItemWidget(
          value: person.percentage,
          name: person.name,
          onChanged: (value) {
            cubit.editPersonPercentage(
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
