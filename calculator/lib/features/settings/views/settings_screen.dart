import 'package:calculator/core/calculator_cubit/calculator_cubit.dart';
import 'package:calculator/core/calculator_cubit/calculator_state.dart';
import 'package:calculator/core/functions.dart';
import 'package:calculator/core/resources/strings_manager.dart';
import 'package:calculator/core/resources/styles_manager.dart';
import 'package:calculator/core/widgets/custom_elevated_button.dart';
import 'package:calculator/core/widgets/custom_text_form_field.dart';
import 'package:calculator/features/settings/views/edit_kit_list.dart';
import 'package:calculator/features/settings/views/edit_persons_list_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class SttingsScreen extends StatelessWidget {
  const SttingsScreen({super.key});

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
                  ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      String key = cubit.personKeys[index];
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            key,
                            style: TextStylesManager.textStyle20,
                          ),

                          // percentage
                          Text(
                            '${cubit.persons[key]}%',
                            style: TextStylesManager.textStyle20,
                          ),
                        ],
                      );
                    },
                    separatorBuilder: (context, index) => const Gap(10),
                    itemCount: cubit.personKeys.length,
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
                              builder: (context) => const EditPersonsList(),
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
                            dest: const EditKitList(),
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
