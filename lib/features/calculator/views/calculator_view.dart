import 'package:azulzinho/core/utils/constants_manager.dart';
import 'package:azulzinho/core/utils/dependency_injection.dart';
import 'package:azulzinho/core/utils/functions.dart';
import 'package:azulzinho/core/widgets/custom_elevated_button.dart';
import 'package:azulzinho/core/widgets/custom_error_widget.dart';
import 'package:azulzinho/core/widgets/custom_text_form_field.dart';
import 'package:azulzinho/core/widgets/loading_widget.dart';
import 'package:azulzinho/features/app_layout/app_layout_cubit/app_states.dart';
import 'package:azulzinho/features/calculator/calculator_cubit/calculator_cubit.dart';
import 'package:azulzinho/features/calculator/views/report_view.dart';
import 'package:azulzinho/features/calculator/widgets/calculator/kits_list_with_clear_button.dart';
import 'package:azulzinho/themes/strings_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../widgets/calculator/expenses_field.dart';
import '../widgets/calculator/extra_field.dart';

class CalculatorView extends StatelessWidget {
  CalculatorView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CalculatorCubit, AppStates>(
      builder: (context, state) {
        if (state is LoadingDataState) {
          return const LoadingWidget();
        } else if (state is LoadingDataErrorState) {
          return CustomErrorWidget(state.message);
        }

        // Success state
        return Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 0.04.sw,
            vertical: 0.02.sh,
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                KitsListWithClearButton(),
                Column(
                  children: [
                    ExpensesField(),
                    ExtraField(),

                    // Note field
                    Padding(
                      padding: EdgeInsets.only(
                        top: 20.h,
                        bottom: 40.h,
                      ),
                      child: CustomTextFormField(
                        controller: locator<CalculatorCubit>().noteController,
                        keyboardType: TextInputType.text,
                        labelText: CalculatorStrings.note,
                        onChanged: (note) =>
                            locator<CalculatorCubit>().note = note,
                      ),
                    ),

                    // Calculate button
                    CustomElevatedButton(
                      fontSize: isTablet ? 18 : 24,
                      width: 1.sw,
                      onPressed: () {
                        locator<CalculatorCubit>().calculate();
                        navigateTo(context: context, dest: ReportView());
                      },
                      text: CalculatorStrings.calculate,
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
