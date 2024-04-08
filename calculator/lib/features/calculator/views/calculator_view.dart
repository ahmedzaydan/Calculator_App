import 'package:calculator/app/resources/constants_manager.dart';
import 'package:calculator/app/resources/strings_manager.dart';
import 'package:calculator/app/resources/styles_manager.dart';
import 'package:calculator/app/utils/dependency_injection.dart';
import 'package:calculator/app/utils/functions.dart';
import 'package:calculator/app/widgets/custom_elevated_button.dart';
import 'package:calculator/app/widgets/custom_list_view.dart';
import 'package:calculator/app/widgets/custom_text_form_field.dart';
import 'package:calculator/features/app_layout/app_layout_cubit/app_states.dart';
import 'package:calculator/features/calculator/calculator_cubit/calculator_cubit.dart';
import 'package:calculator/features/calculator/views/report_view.dart';
import 'package:calculator/features/calculator/widgets/kit_item_with_checkbox.dart';
import 'package:calculator/features/kits/kit_cubit/kit_cubit.dart';
import 'package:calculator/features/kits/models/kit_model.dart';
import 'package:calculator/features/widgets/custom_error_widget.dart';
import 'package:calculator/features/widgets/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class CalculatorView extends StatelessWidget {
  CalculatorView({super.key});

  final TextEditingController expensesController = TextEditingController();
  final TextEditingController extraController = TextEditingController();
  final TextEditingController noteController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CalculatorCubit, AppStates>(
      builder: (context, state) {
        var cubit = CalculatorCubit.get(context);
        // var personsCubit = locator<PersonsCubit>();
        if (state is LoadingDataState) {
          return const LoadingWidget();
        } else if (state is LoadingDataErrorState) {
          return CustomErrorWidget(state.message);
        }
        return Padding(
          padding: EdgeInsets.all(
            MediaQuery.of(context).size.width * 0.02,
          ),
          child: SingleChildScrollView(
            child: Column(
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

                // kits list
                BlocBuilder<KitsCubit, AppStates>(
                  builder: (context, state) {
                    var profitCubit = locator<KitsCubit>();
                    return CustomListView(
                      itemBuilder: (context, index) {
                        KitModel profit = profitCubit.kitItems[index];
                        return KitItemWithCheckbox(
                          profitId: profit.name,
                          profitValue: profit.value,
                          value: profit.isChecked,
                          onChanged: (_) async {
                            await profitCubit.changeKitStatus(index);
                          },
                        );
                      },
                      separatorBuilder: (context, index) => const Gap(1),
                      itemCount: profitCubit.kitItems.length,
                    );
                  },
                ),

                const Gap(25),

                // expense section
                CustomTextFormField(
                  controller: expensesController,
                  fontWeight: FontWeight.normal,
                  labelText: StringsManager.expenses,
                  hintText: StringsManager.expansesHint,
                  onChanged: (value) => cubit.expenses = value,
                  keyboardType: TextInputType.text,
                  inputFormatters: getInputFormatters(
                    ConstantsManager.calculatorRegex,
                  ),
                ),

                const Gap(25),

                // extra section
                CustomTextFormField(
                  controller: extraController,
                  fontWeight: FontWeight.normal,
                  labelText: StringsManager.extra,
                  hintText: StringsManager.expansesHint,
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
                        dest: ReportView(),
                      );
                    },
                    text: 'Calculate',
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
