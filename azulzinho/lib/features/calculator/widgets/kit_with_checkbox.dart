import 'package:azulzinho/themes/color_manager.dart';
import 'package:azulzinho/themes/styles_manager.dart';
import 'package:azulzinho/core/utils/functions.dart';
import 'package:azulzinho/features/kits/models/kit_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class KitWithCheckbox extends StatelessWidget {
  const KitWithCheckbox({
    super.key,
    required this.kit,
    required this.onChanged,
  });

  final KitModel kit;
  final void Function(bool?)? onChanged;

  @override
  Widget build(BuildContext context) {
    Color color = kit.isChecked ? ColorManager.lightGrey : ColorManager.black;

    return Row(
      children: [
        // checkbox
        Transform.scale(
          scale: 1.6.sp,
          child: Checkbox(
            side: BorderSide(
              color: Theme.of(context).primaryColor,
              width: 2.sp,
            ),
            fillColor: MaterialStateProperty.all(
              kit.isChecked ? ColorManager.primary : ColorManager.transparent,
            ),
            checkColor: ColorManager.white,
            value: kit.isChecked,
            onChanged: onChanged,
          ),
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
