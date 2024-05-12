import 'package:azulzinho/app/resources/color_manager.dart';
import 'package:azulzinho/app/resources/strings_manager.dart';
import 'package:azulzinho/app/resources/styles_manager.dart';
import 'package:azulzinho/app/utils/dependency_injection.dart';
import 'package:azulzinho/app/utils/functions.dart';
import 'package:azulzinho/app/widgets/custom_elevated_button.dart';
import 'package:azulzinho/app/widgets/custom_error_widget.dart';
import 'package:azulzinho/app/widgets/custom_text_form_field.dart';
import 'package:azulzinho/app/widgets/loading_widget.dart';
import 'package:azulzinho/features/app_layout/app_layout_cubit/app_states.dart';
import 'package:azulzinho/features/calculator/calculator_cubit/calculator_cubit.dart';
import 'package:azulzinho/features/calculator/views/report_view.dart';
import 'package:azulzinho/features/calculator/widgets/collapsible_kits_list_with_clear_button.dart';
import 'package:azulzinho/features/calculator/widgets/kits_list_with_checkbox.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
            horizontal: 0.04.sw,
            vertical: 0.02.sh,
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

                Gap(20.h),

                KitsListWithCheckbox(),

                Gap(25.h),

                // expense section
                CustomTextFormField(
                  controller: expensesController,
                  keyboardType: TextInputType.text,
                  labelText: CalculatorStrings.expenses,
                  hintText: CalculatorStrings.expansesHint,
                  onChanged: (value) => cubit.expenses = value,
                ),

                Gap(25.h),

                // extra section
                CustomTextFormField(
                  controller: extraController,
                  keyboardType: TextInputType.text,
                  labelText: CalculatorStrings.extra,
                  hintText: CalculatorStrings.expansesHint,
                  onChanged: (value) => cubit.extra = value,
                ),

                Gap(25.h),

                // note
                CustomTextFormField(
                  controller: noteController,
                  keyboardType: TextInputType.text,
                  labelText: CalculatorStrings.note,
                  onChanged: (note) => cubit.note = note,
                ),

                Gap(25.h),

                // calculate button
                SizedBox(
                  width: 1.sw,
                  child: CustomElevatedButton(
                    onPressed: () {
                      cubit.calculate();
                      navigateTo(
                        context: context,
                        dest: ReportView(),
                      );
                    },
                    text: CalculatorStrings.calculate,
                    textStyle: TextStylesManager.textStyle32.copyWith(
                      color: ColorManager.white,
                      fontWeight: FontWeight.w700,
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
