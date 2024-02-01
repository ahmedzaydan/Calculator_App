import 'package:calculator/core/functions.dart';
import 'package:calculator/core/resources/strings_manager.dart';
import 'package:calculator/core/resources/styles_manager.dart';
import 'package:calculator/core/widgets/custom_elevated_button.dart';
import 'package:calculator/core/widgets/custom_text_form_field.dart';
import 'package:calculator/features/home/cubit/calculator_cubit.dart';
import 'package:calculator/features/home/cubit/calculator_state.dart';
import 'package:calculator/features/settings/views/edit_persons_list_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class SttingsScreen extends StatelessWidget {
  const SttingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(text: StringsManager.settings),
      body: BlocBuilder<CalculatorCubit, CalculatorState>(
        builder: (context, state) {
          var cubit = CalculatorCubit.get(context);
          return Padding(
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
                          heightValue: 0.08,
                          onPressed: () {
                            cubit.saveData();
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
                      String key = cubit.keys[index];
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
                    itemCount: cubit.keys.length,
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

                      // reset profit values button
                      CustomElevatedButton(
                        onPressed: () {
                          // cubit.resetProfitValues();
                        },
                        text: StringsManager.clearList,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
