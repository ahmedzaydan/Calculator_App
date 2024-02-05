import 'package:calculator/core/widgets/custom_icon_button.dart';
import 'package:calculator/core/widgets/custom_text_form_field.dart';
import 'package:calculator/core/cubit/calculator_cubit.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class EditPerson extends StatelessWidget {
  const EditPerson({
    super.key,
    required this.cubit,
    required this.personKey,
    required this.index,
  });

  final CalculatorCubit cubit;
  final String personKey;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: CustomTextFormField(
            controller: TextEditingController(
              text: cubit.persons[personKey].toString(),
            ),
            labelText: personKey,
            onChanged: (value) {
              cubit.persons[personKey] = double.parse(value);
            },
          ),
        ),

        const Gap(10),

        // delete person button
        CustomIconButton(
          onPressed: () async {
            await cubit.deletePerson(
              name: personKey,
              index: index,
            );
          },
          icon: const Icon(
            Icons.delete
          ),
        ),
      ],
    );
  }
}
