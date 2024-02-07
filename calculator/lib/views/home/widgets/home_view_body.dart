import 'package:calculator/core/calculator_cubit/calculator_cubit.dart';
import 'package:calculator/core/calculator_cubit/calculator_state.dart';
import 'package:calculator/core/models/profit_model.dart';
import 'package:calculator/core/resources/strings_manager.dart';
import 'package:calculator/core/resources/styles_manager.dart';
import 'package:calculator/core/utils/functions.dart';
import 'package:calculator/core/widgets/custom_elevated_button.dart';
import 'package:calculator/core/widgets/custom_list_view.dart';
import 'package:calculator/core/widgets/custom_text_form_field.dart';
import 'package:calculator/views/home/widgets/profit_item.dart';
import 'package:calculator/views/output/views/output_view.dart';
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
                    StringsManager.kits,
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

            // profits list
            CustomListView(
              itemBuilder: (context, index) {
                ProfitModel profit = cubit.profitItems[index];
                return ProfitItem(
                  profitId: profit.id,
                  profitValue: profit.value,
                  value: profit.status,
                  onChanged: (_) => cubit.changeProfitStatus(index),
                );
              },
              separatorBuilder: (context, index) => const Gap(1),
              itemCount: cubit.profitItems.length,
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
                    dest: const OutputView(),
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
