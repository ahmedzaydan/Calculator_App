import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/resources/strings_manager.dart';
import '../../../../core/utils/dependency_injection.dart';
import '../../../../core/utils/functions.dart';
import '../../../../core/widgets/custom_elevated_button.dart';
import '../../calculator_cubit/calculator_cubit.dart';
import '../../views/report_view.dart';

class CalculateButton extends StatelessWidget {
  const CalculateButton({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 1.sw,
      child: CustomElevatedButton(
        fontSize: 24.sp,
        onPressed: () {
          locator<CalculatorCubit>().calculate();
          navigateTo(
            context: context,
            dest: ReportView(),
          );
        },
        text: CalculatorStrings.calculate,
      ),
    );
  }
}
