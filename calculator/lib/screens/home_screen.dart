import 'package:calculator/core/functions.dart';
import 'package:calculator/cubit/calculator_cubit.dart';
import 'package:calculator/cubit/calculator_state.dart';
import 'package:calculator/screens/output_screen.dart';
import 'package:calculator/screens/settings_screen.dart';
import 'package:calculator/screens/widgets/custom_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Home Calculator Screen',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              navigateTo(context: context, dest: const SttingsScreen());
            },
            icon: const Icon(Icons.settings),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: BlocConsumer<CalculatorCubit, CalculatorState>(
            listener: (context, state) {},
            builder: (context, state) {
              var cubit = CalculatorCubit.get(context);
              return Column(
                children: [
                  // profit fields
                  ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: cubit.profitFields.length,
                    itemBuilder: (context, index) {
                      return cubit.profitFields[index];
                    },
                    separatorBuilder: (context, index) => const Gap(10),
                  ),

                  const Gap(20),

                  // profit buttons
                  Row(
                    children: [
                      // add profit field button
                      Expanded(
                        child: CustomElevatedButton(
                          onPressed: () => cubit.addProfitField(),
                          text: 'Add profit',
                        ),
                      ),

                      const Gap(10),

                      // delete profit field button
                      Expanded(
                        child: CustomElevatedButton(
                          onPressed: () => cubit.deleteProfitField(),
                          text: 'Delete profit',
                        ),
                      ),
                    ],
                  ),

                  const Gap(25),

                  // expense fields
                  ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: cubit.expenseFields.length,
                    itemBuilder: (context, index) {
                      return cubit.expenseFields[index];
                    },
                    separatorBuilder: (context, index) => const Gap(10),
                  ),

                  const Gap(20),

                  // expense buttons
                  Row(
                    children: [
                      // add expense field button
                      Expanded(
                        child: CustomElevatedButton(
                          onPressed: () => cubit.addExpenseField(),
                          text: 'Add expanse',
                        ),
                      ),

                      const Gap(10),

                      // delete expense field button
                      Expanded(
                        child: CustomElevatedButton(
                          onPressed: () => cubit.deleteExpenseField(),
                          text: 'Delete expanse',
                        ),
                      ),
                    ],
                  ),
                  const Gap(25),

                  // calculate button
                  SizedBox(
                    width: double.infinity,
                    child: CustomElevatedButton(
                      onPressed: () {
                        cubit.calculate();
                        navigateTo(
                            context: context, dest: const OutputScreen());
                      },
                      text: 'Calculate',
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
