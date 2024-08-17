import 'package:azulzinho/core/utils/constants_manager.dart';
import 'package:azulzinho/themes/strings_manager.dart';
import 'package:azulzinho/core/utils/dependency_injection.dart';
import 'package:azulzinho/core/widgets/custom_text_form_field.dart';
import 'package:azulzinho/features/calculator/calculator_cubit/calculator_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ExpensesField extends StatelessWidget {
  const ExpensesField({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: 22.h,
      ),
      child: CustomTextFormField(
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
      ),
    );
  }
}
