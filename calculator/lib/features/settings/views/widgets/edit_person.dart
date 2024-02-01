import 'package:calculator/core/widgets/custom_text_form_field.dart';
import 'package:calculator/features/home/cubit/calculator_cubit.dart';
import 'package:flutter/material.dart';

class EditPerson extends StatelessWidget {
  const EditPerson({
    super.key,
    required this.cubit,
    required this.personKey, required this.index,
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

        // delete person button
        IconButton(
          onPressed: () async {
            await cubit.deletePerson(
              name: personKey,
              index: index,
            );
          },
          iconSize: 40,
          icon: const Icon(
            Icons.delete,
            color: Colors.red,
          ),
        ),
      ],
    );
  }
}
