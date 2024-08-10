import 'package:azulzinho/core/resources/constants_manager.dart';
import 'package:azulzinho/core/utils/functions.dart';
import 'package:azulzinho/features/kits/models/kit_model.dart';
import 'package:azulzinho/themes/color_manager.dart';
import 'package:azulzinho/themes/styles_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

import 'calculator_check_box.dart';

class KitWithCheckbox extends StatelessWidget {
  const KitWithCheckbox({
    super.key,
    required this.kit,
  });

  final KitModel kit;

  @override
  Widget build(BuildContext context) {
    Color color = kit.isChecked ? ColorManager.lightGrey : ColorManager.black;

    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        CalculatorCheckBox(kit: kit),

        Gap(
          isTablet ? 10.w : 0,
        ),

        // kit name
        Text(
          kit.name,
          style: getBoldStyle(color: color),
        ),

        Gap(5.h),

        // kit start date
        Text(
          '(${getDateAsString(date: kit.startDate)})',
          style: getRegularStyle(color: color),
        ),

        const Spacer(),

        // kit value
        Text(
          '${kit.value}',
          style: getBoldStyle(color: color),
        ),
      ],
    );
  }
}
