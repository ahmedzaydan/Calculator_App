import 'package:azulzinho/core/resources/strings_manager.dart';
import 'package:azulzinho/core/utils/dependency_injection.dart';
import 'package:azulzinho/core/widgets/custom_text_form_field.dart';
import 'package:azulzinho/features/calculator/calculator_cubit/calculator_cubit.dart';
import 'package:flutter/material.dart';

class NoteField extends StatelessWidget {
  const NoteField({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomTextFormField(
      controller: locator<CalculatorCubit>().noteController,
      keyboardType: TextInputType.text,
      labelText: CalculatorStrings.note,
      onChanged: (note) => locator<CalculatorCubit>().note = note,
    );
  }
}
