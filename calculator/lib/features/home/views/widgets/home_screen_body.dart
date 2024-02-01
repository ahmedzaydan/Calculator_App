import 'package:calculator/features/home/cubit/calculator_cubit.dart';
import 'package:calculator/features/home/cubit/calculator_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreenBody extends StatelessWidget {
  HomeScreenBody({
    super.key,
  });

  final TextEditingController kitNumbersController = TextEditingController();
  final TextEditingController noteController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CalculatorCubit, CalculatorState>(
      builder: (context, state) {
        var cubit = CalculatorCubit.get(context);
        return const Column(
          children: [
            //   // profit section
            //   Section(
            //     itemCount: cubit.profitList.length,
            //     itemBuilder: (context, index) {
            //       return cubit.profitFields[index];
            //     },
            //     addText: 'Add Profit',
            //     addOnPressed: () => cubit.addProfitField(),
            //     deleteText: 'Delete Profit',
            //     deleteOnPressed: () => cubit.deleteProfitField(),
            //   ),

            //   const Gap(25),

            //   // expense section
            //   Section(
            //     itemCount: cubit.expenseList.length,
            //     itemBuilder: (context, index) {
            //       return cubit.expenseFields[index];
            //     },
            //     addText: 'Add Expense',
            //     addOnPressed: () => cubit.addExpenseField(),
            //     deleteText: 'Delete Expense',
            //     deleteOnPressed: () => cubit.deleteExpenseField(),
            //   ),

            //   const Gap(25),

            //   // kit numbers
            //   CustomTextFormField(
            //     controller: kitNumbersController,
            //     labelText: 'Kit numbers',
            //     onChanged: (kitNumbers) {
            //       cubit.kitNumbers = int.parse(kitNumbers);
            //     },
            //   ),

            //   const Gap(25),

            //   // note
            //   CustomTextFormField(
            //     controller: noteController,
            //     keyboardType: TextInputType.text,
            //     labelText: 'Note',
            //     onChanged: (note) {
            //       cubit.note = note;
            //       print(cubit.note);
            //     },
            //   ),
            //   const Gap(25),
            //   // calculate button
            //   SizedBox(
            //     width: double.infinity,
            //     child: CustomElevatedButton(
            //       onPressed: () {
            //         cubit.calculate();
            //         navigateTo(context: context, dest: const OutputScreen());
            //       },
            //       text: 'Calculate',
            //     ),
            //   ),
          ],
        );
      },
    );
  }
}
