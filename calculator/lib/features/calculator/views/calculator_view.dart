import 'package:calculator/app/resources/color_manager.dart';
import 'package:calculator/app/resources/font_manager.dart';
import 'package:calculator/app/resources/strings_manager.dart';
import 'package:calculator/app/utils/dependency_injection.dart';
import 'package:calculator/app/utils/functions.dart';
import 'package:calculator/app/widgets/custom_elevated_button.dart';
import 'package:calculator/app/widgets/custom_text_form_field.dart';
import 'package:calculator/features/app_layout/app_layout_cubit/app_states.dart';
import 'package:calculator/features/calculator/calculator_cubit/calculator_cubit.dart';
import 'package:calculator/features/calculator/views/report_view.dart';
import 'package:calculator/features/calculator/widgets/collapsible_kits_list_with_clear_button.dart';
import 'package:calculator/features/calculator/widgets/kits_list_with_checkbox.dart';
import 'package:calculator/app/widgets/custom_error_widget.dart';
import 'package:calculator/app/widgets/loading_widget.dart';
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
        var cubit = locator<CalculatorCubit>();

        if (state is LoadingDataState) {
          return const LoadingWidget();
        } else if (state is LoadingDataErrorState) {
          return CustomErrorWidget(state.message);
        }
        return Padding(
          padding: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width * 0.04,
            vertical: MediaQuery.of(context).size.height * 0.02,
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                CollapsibleKitsListWithClearButton(
                  clearOnPressed: () async {
                    expensesController.clear();
                    extraController.clear();
                    noteController.clear();
                    await cubit.clear();
                  },
                ),

                const Gap(20),

                KitsListWithCheckbox(),

                const Gap(25),

                // expense section
                CustomTextFormField(
                  controller: expensesController,
                  keyboardType: TextInputType.text,
                  labelText: CalculatorStrings.expenses,
                  hintText: CalculatorStrings.expansesHint,
                  onChanged: (value) => cubit.expenses = value,
                ),

                const Gap(25),

                // extra section
                CustomTextFormField(
                  controller: extraController,
                  keyboardType: TextInputType.text,
                  labelText: CalculatorStrings.extra,
                  hintText: CalculatorStrings.expansesHint,
                  onChanged: (value) => cubit.extra = value,
                ),

                const Gap(25),

                // note
                CustomTextFormField(
                  controller: noteController,
                  keyboardType: TextInputType.text,
                  labelText: CalculatorStrings.note,
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
                    text: CalculatorStrings.calculate,
                    textStyle: TextStyle(
                      fontSize: FontSize.s28,
                      fontWeight: FontWeight.bold,
                      color: ColorManager.white,
                    ),
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
