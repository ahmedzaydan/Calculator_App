import 'package:calculator/core/calculator_cubit/calculator_cubit.dart';
import 'package:calculator/core/functions.dart';
import 'package:calculator/core/widgets/custom_icon_button.dart';
import 'package:calculator/core/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class AddItemWidget extends StatelessWidget {
  AddItemWidget({
    super.key,
    required this.name,
    required this.nameValidator,
    required this.value,
    required this.valueValidator,
    this.isPerson = false,
    this.inputType = TextInputType.text,
  });

  final TextEditingController nameController = TextEditingController();
  final TextEditingController valueController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  final String name;
  final String nameValidator;

  final String value;
  final String valueValidator;

  final bool isPerson;

  final TextInputType inputType;
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // item lable
          Expanded(
            flex: 3,
            child: CustomTextFormField(
              controller: nameController,
              labelText: name,
              keyboardType: inputType,
              validator: (value) {
                if (value!.isEmpty) {
                  return nameValidator;
                }
                return null;
              },
            ),
          ),

          const Gap(10),

          // item value
          Expanded(
            flex: 3,
            child: CustomTextFormField(
              controller: valueController,
              labelText: value,
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
              ),
              inputFormatters: getInputFormatters(),
              validator: (value) {
                if (value!.isEmpty) {
                  return valueValidator;
                }
                return null;
              },
            ),
          ),

          const Gap(10),

          // add button
          CustomIconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                if (isPerson) {
                  CalculatorCubit.get(context).addPerson(
                    name: nameController.text,
                    percentage: double.parse(valueController.text),
                  );
                } else {
                  CalculatorCubit.get(context).addProfitItem(
                    profitId: nameController.text,
                    value: double.parse(valueController.text),
                  );
                }
              }
            },
          ),
        ],
      ),
    );
  }
}
