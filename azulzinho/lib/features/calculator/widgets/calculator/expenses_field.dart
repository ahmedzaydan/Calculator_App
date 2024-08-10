import 'package:azulzinho/core/resources/constants_manager.dart';
import 'package:azulzinho/core/resources/strings_manager.dart';
import 'package:azulzinho/core/utils/dependency_injection.dart';
import 'package:azulzinho/core/widgets/custom_text_form_field.dart';
import 'package:azulzinho/features/calculator/calculator_cubit/calculator_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ExpensesField extends StatelessWidget {
  const ExpensesField({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomTextFormField(
      controller: locator<CalculatorCubit>().expensesController,
      keyboardType: TextInputType.text,
      inputFormatters: [
        // Deny anything except numbers, dots, and spaces
        FilteringTextInputFormatter.deny(
          RegExp(ConstantsManager.calculatorRegex),
        ),
      ],
      labelText: CalculatorStrings.expenses,
      hintText: CalculatorStrings.expansesHint,
      onChanged: (value) => locator<CalculatorCubit>().expenses = value,
    );
  }
}
