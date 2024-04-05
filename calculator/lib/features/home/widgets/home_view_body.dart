import 'package:calculator/app/calculator_cubit/calculator_cubit.dart';
import 'package:calculator/app/calculator_cubit/calculator_state.dart';
import 'package:calculator/app/models/profit_model.dart';
import 'package:calculator/app/resources/strings_manager.dart';
import 'package:calculator/app/resources/styles_manager.dart';
import 'package:calculator/app/utils/functions.dart';
import 'package:calculator/app/widgets/custom_elevated_button.dart';
import 'package:calculator/app/widgets/custom_list_view.dart';
import 'package:calculator/app/widgets/custom_text_form_field.dart';
import 'package:calculator/features/home/widgets/profit_item.dart';
import 'package:calculator/features/output/views/output_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class HomeViewBody extends StatelessWidget {
  HomeViewBody({
    super.key,
  });

  final TextEditingController expensesController = TextEditingController();
  final TextEditingController extraController = TextEditingController();
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

                  // clera button
                  SizedBox(
                    height: MediaQuery.of(context).size.width * 0.12,
                    child: CustomElevatedButton(
                      onPressed: () async {
                        expensesController.clear();
                        extraController.clear();
                        noteController.clear();
                        await cubit.clear();
                      },
                      text: StringsManager.clear,
                    ),
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
                  profitId: 'Kit ${profit.id.substring(1)}',
                  profitValue: profit.value,
                  value: profit.isChecked,
                  onChanged: (_) async {
                    await cubit.changeProfitStatus(index);
                  },
                );
              },
              separatorBuilder: (context, index) => const Gap(1),
              itemCount: cubit.profitItems.length,
            ),

            const Gap(25),

            // expense section
            CustomTextFormField(
              controller: expensesController,
              fontWeight: FontWeight.normal,
              labelText: StringsManager.expenses,
              hintText: StringsManager.valuesHint,
              onChanged: (value) => cubit.expenses = value,
            ),

            const Gap(25),

            // extra section
            CustomTextFormField(
              controller: extraController,
              fontWeight: FontWeight.normal,
              labelText: StringsManager.extra,
              hintText: StringsManager.valuesHint,
              onChanged: (value) => cubit.extra = value,
            ),

            const Gap(25),

            // note
            CustomTextFormField(
              controller: noteController,
              fontWeight: FontWeight.normal,
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
