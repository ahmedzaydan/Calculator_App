import 'package:calculator/core/resources/strings_manager.dart';
import 'package:calculator/core/widgets/custom_icon_button.dart';
import 'package:calculator/core/widgets/custom_text_form_field.dart';
import 'package:calculator/features/home/cubit/calculator_cubit.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class AddPersonWidget extends StatelessWidget {
  AddPersonWidget({
    super.key,
  });

  final TextEditingController nameController = TextEditingController();
  final TextEditingController percentageController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // person name
          Expanded(
            flex: 3,
            child: CustomTextFormField(
              controller: nameController,
              labelText: StringsManager.name,
              keyboardType: TextInputType.text,
              validator: (value) {
                if (value!.isEmpty) {
                  return StringsManager.enterName;
                }
                return null;
              },
            ),
          ),

          const Gap(10),

          // person percentage
          Expanded(
            flex: 3,
            child: CustomTextFormField(
              controller: percentageController,
              labelText: StringsManager.percentage,
              validator: (value) {
                if (value!.isEmpty) {
                  return StringsManager.enterPercentage;
                }
                return null;
              },
            ),
          ),

          const Gap(10),

          // add button
          CustomIconButton(
            icon: const Icon(
              Icons.add,
              color: Colors.white,
            ),
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                CalculatorCubit.get(context).addPerson(
                  name: nameController.text,
                  percentage: double.parse(percentageController.text),
                );
                // Navigator.pop(context);
              }
            },
          ),
        ],
      ),
    );
  }
}
