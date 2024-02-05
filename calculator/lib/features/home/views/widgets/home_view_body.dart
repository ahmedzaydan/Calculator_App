import 'package:calculator/core/cubit/calculator_cubit.dart';
import 'package:calculator/core/cubit/calculator_state.dart';
import 'package:calculator/core/functions.dart';
import 'package:calculator/core/resources/strings_manager.dart';
import 'package:calculator/core/resources/styles_manager.dart';
import 'package:calculator/core/widgets/custom_elevated_button.dart';
import 'package:calculator/core/widgets/custom_text_form_field.dart';
import 'package:calculator/features/home/views/widgets/profit_item.dart';
import 'package:calculator/features/home/views/widgets/profits_grid_view.dart';
import 'package:calculator/features/output/views/output_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class HomeViewBody extends StatelessWidget {
  HomeViewBody({
    super.key,
  });

  final TextEditingController expensesController = TextEditingController();
  final TextEditingController noteController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CalculatorCubit, CalculatorState>(
      builder: (context, state) {
        var cubit = CalculatorCubit.get(context);
        return Column(
          children: [
            Padding(
              padding: EdgeInsets.only(
                left: MediaQuery.of(context).size.width * 0.02,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    StringsManager.profits,
                    style: TextStylesManager.textStyle20.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  CustomElevatedButton(
                    onPressed: () {
                      cubit.clearProfitItems();
                    },
                    text: StringsManager.clear,
                  ),
                ],
              ),
            ),

            const Gap(10),

            ProfitsGridView(
              itemsCount: cubit.profitKeys.length,
              itemBuilder: (context, index) {
                String profitId = cubit.profitKeys[index];
                return ProfitItem(
                  profitId: profitId,
                  profitValue: cubit.profits[profitId].toString(),
                  value: cubit.profitItemStates[profitId] ?? false,
                  onChanged: (_) {
                    cubit.changeProfitStatus(profitId);
                  },
                );
              },
            ),

            const Gap(25),

            // expense section
            CustomTextFormField(
              controller: expensesController,
              labelText: StringsManager.expenses,
              hintText: 'value1,  value2, ',
              onChanged: (value) => cubit.expenses = value,
            ),

            const Gap(25),

            // note
            CustomTextFormField(
              controller: noteController,
              keyboardType: TextInputType.text,
              labelText: StringsManager.note,
              onChanged: (note) {
                cubit.note = note;
              },
            ),

            const Gap(25),

            // calculate button
            SizedBox(
              width: double.infinity,
              child: CustomElevatedButton(
                onPressed: () {
                  cubit.calculate();
                  navigateTo(
                    context: context,
                    dest: const OutputScreen(),
                  );
                },
                text: 'Calculate',
              ),
            ),
          ],
        );
      },
    );
  }
}
