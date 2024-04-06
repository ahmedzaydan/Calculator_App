import 'package:calculator/app/resources/strings_manager.dart';
import 'package:calculator/app/resources/styles_manager.dart';
import 'package:calculator/app/utils/dependency_injection.dart';
import 'package:calculator/app/utils/functions.dart';
import 'package:calculator/app/widgets/custom_elevated_button.dart';
import 'package:calculator/app/widgets/custom_list_view.dart';
import 'package:calculator/app/widgets/custom_text_form_field.dart';
import 'package:calculator/features/home/calculator_cubit/calculator_cubit.dart';
import 'package:calculator/features/home/calculator_cubit/calculator_state.dart';
import 'package:calculator/features/home/widgets/profit_item.dart';
import 'package:calculator/features/output/views/output_view.dart';
import 'package:calculator/features/settings/persons/person_cubit/persons_cubit.dart';
import 'package:calculator/features/settings/profits/models/profit_model.dart';
import 'package:calculator/features/settings/profits/profit_cubit/profit_cubit.dart';
import 'package:calculator/features/settings/profits/profit_cubit/profit_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class HomeViewBody extends StatelessWidget {
  HomeViewBody({super.key});

  final TextEditingController expensesController = TextEditingController();
  final TextEditingController extraController = TextEditingController();
  final TextEditingController noteController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CalculatorCubit, CalculatorStates>(
      builder: (context, state) {
        var cubit = CalculatorCubit.get(context);
        var personsCubit = locator<PersonsCubit>();
        if (state is LoadingDataState) {
          return const Center(child: CircularProgressIndicator());
        }
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
            BlocBuilder<ProfitsCubit, ProfitsStates>(
              builder: (context, state) {
                var profitCubit = locator<ProfitsCubit>();
                return CustomListView(
                  itemBuilder: (context, index) {
                    ProfitModel profit = profitCubit.profitItems[index];
                    return ProfitItem(
                      profitId: profit.id,
                      profitValue: profit.value,
                      value: profit.isChecked,
                      onChanged: (_) async {
                        await profitCubit.changeProfitStatus(index);
                      },
                    );
                  },
                  separatorBuilder: (context, index) => const Gap(1),
                  itemCount: profitCubit.profitItems.length,
                );
              },
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
              onChanged: (note) => cubit.note = note,
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
