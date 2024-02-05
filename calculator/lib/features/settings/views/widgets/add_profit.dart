import 'package:calculator/core/resources/strings_manager.dart';
import 'package:calculator/core/widgets/custom_icon_button.dart';
import 'package:calculator/core/widgets/custom_text_form_field.dart';
import 'package:calculator/features/home/cubit/calculator_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';

class AddProfitWidget extends StatelessWidget {
  AddProfitWidget({super.key});

  final TextEditingController profitNumController = TextEditingController();
  final TextEditingController profitValueController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // profit number
          Expanded(
            flex: 3,
            child: CustomTextFormField(
              controller: profitNumController,
              labelText: StringsManager.profitNumber,
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              validator: (value) {
                if (value!.isEmpty) {
                  return StringsManager.enterNumber;
                }
                return null;
              },
            ),
          ),

          const Gap(10),

          // profit value
          Expanded(
            flex: 3,
            child: CustomTextFormField(
              controller: profitValueController,
              labelText: StringsManager.profitValue,
              validator: (value) {
                if (value!.isEmpty) {
                  return StringsManager.enterValue;
                }
                return null;
              },
            ),
          ),

          const Gap(10),

          // add button
          CustomIconButton(
            icon: const Icon(
              Icons.add
            ),
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                CalculatorCubit.get(context).addProfitItem(
                  profitId: profitNumController.text,
                  value: double.parse(profitValueController.text),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
