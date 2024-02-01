import 'package:calculator/features/home/cubit/calculator_cubit.dart';
import 'package:calculator/features/home/cubit/calculator_state.dart';
import 'package:calculator/features/settings/add_person_screen.dart';
import 'package:calculator/core/widgets/custom_elevated_button.dart';
import 'package:calculator/core/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class SttingsScreen extends StatelessWidget {
  const SttingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Settings Screen',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: BlocBuilder<CalculatorCubit, CalculatorState>(
        builder: (context, state) {
          var cubit = CalculatorCubit.get(context);
          return Padding(
            padding: const EdgeInsets.all(20.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  // adminstration percentage
                  CustomTextFormField(
                    controller: TextEditingController(
                      text: cubit.adminPercentage.toString(),
                    ),
                    labelText: 'Adminstration percentage',
                    onChanged: (value) {
                      cubit.adminPercentage = double.parse(value);
                    },
                  ),

                  const Gap(20),
                  // persons percentage
                  ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      String key = cubit.keys[index];
                      return Row(
                        children: [
                          Expanded(
                            child: CustomTextFormField(
                              controller: TextEditingController(
                                text: cubit.persons[key].toString(),
                              ),
                              labelText: key,
                              onChanged: (value) {
                                cubit.persons[key] = double.parse(value);
                              },
                            ),
                          ),

                          // delete person button
                          IconButton(
                            onPressed: () async {
                              await cubit.deletePerson(name: key, index: index);
                            },
                            icon: const Icon(Icons.delete),
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
                      // add person button
                      CustomElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AddPersonScreen(),
                            ),
                          );
                        },
                        text: 'Add person',
                      ),

                      // save button
                      CustomElevatedButton(
                        onPressed: () {
                          cubit.saveData();
                        },
                        text: 'Save',
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
