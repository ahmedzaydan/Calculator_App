import 'package:azulzinho/core/widgets/custom_error_widget.dart';
import 'package:azulzinho/core/widgets/loading_widget.dart';
import 'package:azulzinho/features/app_layout/app_layout_cubit/app_states.dart';
import 'package:azulzinho/features/calculator/calculator_cubit/calculator_cubit.dart';
import 'package:azulzinho/features/calculator/widgets/calculator/kits_list_with_checkbox.dart';
import 'package:azulzinho/features/calculator/widgets/calculator/kits_list_with_clear_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

import '../widgets/calculator/calculate_button.dart';
import '../widgets/calculator/expenses_field.dart';
import '../widgets/calculator/extra_field.dart';
import '../widgets/calculator/note_field.dart';

class CalculatorView extends StatelessWidget {
  CalculatorView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CalculatorCubit, AppStates>(
      builder: (context, state) {
        var cubit = CalculatorCubit.get(context);

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
                if (!cubit.isKitsListCollapsed) Gap(20.h),
                KitsListWithCheckbox(),
                Gap(25.h),
                ExpensesField(),
                Gap(20.h),
                ExtraField(),
                Gap(20.h),
                NoteField(),
                Gap(40.h),
                CalculateButton(),
              ],
            ),
          ),
        );
      },
    );
  }
}
