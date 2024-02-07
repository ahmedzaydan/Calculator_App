import 'package:calculator/core/calculator_cubit/calculator_cubit.dart';
import 'package:calculator/core/calculator_cubit/calculator_state.dart';
import 'package:calculator/core/utils/functions.dart';
import 'package:calculator/core/models/person_model.dart';
import 'package:calculator/core/resources/strings_manager.dart';
import 'package:calculator/core/resources/styles_manager.dart';
import 'package:calculator/core/widgets/custom_elevated_button.dart';
import 'package:calculator/core/widgets/custom_list_view.dart';
import 'package:calculator/core/widgets/custom_text_form_field.dart';
import 'package:calculator/views/settings/views/edit_kit_list_view.dart';
import 'package:calculator/views/settings/views/edit_persons_list_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class SttingsView extends StatelessWidget {
  const SttingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CalculatorCubit, CalculatorState>(
      builder: (context2, state) {
        var cubit = CalculatorCubit.get(context2);
        return Scaffold(
          appBar: customAppBar(
            text: StringsManager.settings,
            onPressed: () {
              cubit.sortProfits();
              Navigator.pop(context);
            },
          ),
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  // adminstration percentage
                  Row(
                    children: [
                      Expanded(
                        flex: 4,
                        child: CustomTextFormField(
                          controller: TextEditingController(
                            text: cubit.adminPercentage.toString(),
                          ),
                          labelText: StringsManager.adminPercentage,
                          keyboardType: const TextInputType.numberWithOptions(
                              decimal: true),
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(
                              RegExp(r'^\d*\.?\d{0,2}'),
                            ),
                          ],
                          onChanged: (value) {
                            cubit.adminPercentage = double.parse(value);
                          },
                        ),
                      ),

                      const Gap(10),

                      // save button
                      Expanded(
                        flex: 2,
                        child: CustomElevatedButton(
                          onPressed: () {
                            cubit.savePersonsData();
                          },
                          text: StringsManager.save,
                        ),
                      ),
                    ],
                  ),

                  const Gap(20),

                  // persons percentage
                  CustomListView(
                    itemBuilder: (context, index) {
                      PersonModel person = cubit.personItems[index];
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            person.name,
                            style: TextStylesManager.textStyle20,
                          ),

                          // percentage
                          Text(
                            '${person.percentage}%',
                            style: TextStylesManager.textStyle20,
                          ),
                        ],
                      );
                    },
                    itemCount: cubit.personItems.length,
                  ),

                  const Gap(25),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // edit persons button
                      CustomElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const EditPersonsListView(),
                            ),
                          );
                        },
                        text: StringsManager.editPersons,
                      ),

                      // edit profit values button
                      CustomElevatedButton(
                        onPressed: () {
                          navigateTo(
                            context: context,
                            dest: const EditKitListView(),
                          );
                        },
                        text: StringsManager.editKits,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
