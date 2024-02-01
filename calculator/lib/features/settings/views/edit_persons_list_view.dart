import 'package:calculator/core/functions.dart';
import 'package:calculator/core/resources/strings_manager.dart';
import 'package:calculator/core/widgets/custom_elevated_button.dart';
import 'package:calculator/features/home/cubit/calculator_cubit.dart';
import 'package:calculator/features/home/cubit/calculator_state.dart';
import 'package:calculator/features/settings/views/widgets/add_person.dart';
import 'package:calculator/features/settings/views/widgets/edit_person.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class EditPersonsList extends StatelessWidget {
  const EditPersonsList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CalculatorCubit, CalculatorState>(
      builder: (_, state) {
        return Scaffold(
          appBar: customAppBar(text: StringsManager.editPersons),
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: SingleChildScrollView(
              child: BlocBuilder<CalculatorCubit, CalculatorState>(
                builder: (context, state) {
                  var cubit = CalculatorCubit.get(context);

                  return Column(
                    children: [
                      ListView.separated(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          String key = cubit.keys[index];
                          return EditPerson(
                            cubit: cubit,
                            personKey: key,
                            index: index,
                          );
                        },
                        separatorBuilder: (context, index) => const Gap(10),
                        itemCount: cubit.keys.length,
                      ),

                      const Gap(20),

                      AddPersonWidget(),

                      const Gap(20),

                      // save button
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 1,
                        child: CustomElevatedButton(
                          onPressed: () {
                            cubit.saveData();
                          },
                          text: StringsManager.save,
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
        );
      },
    );
  }
}
