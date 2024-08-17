import 'package:azulzinho/core/utils/constants_manager.dart';
import 'package:azulzinho/core/utils/dependency_injection.dart';
import 'package:azulzinho/core/utils/extensions.dart';
import 'package:azulzinho/core/utils/functions.dart';
import 'package:azulzinho/features/app_layout/app_layout_cubit/app_states.dart';
import 'package:azulzinho/features/kits/kit_cubit/kit_cubit.dart';
import 'package:azulzinho/features/kits/models/kit_model.dart';
import 'package:azulzinho/themes/color_manager.dart';
import 'package:azulzinho/themes/styles_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class KitWithCheckbox extends StatelessWidget {
  const KitWithCheckbox({
    super.key,
    required this.kit,
  });

  final KitModel kit;

  @override
  Widget build(BuildContext context) {
    Color color = kit.isChecked ? ColorManager.lightGrey : ColorManager.black;

    return BlocBuilder<KitsCubit, AppStates>(
      builder: (context, state) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Transform.scale(
              scale: 1.sp,
              child: Checkbox(
                visualDensity: VisualDensity.compact,
                side: BorderSide(
                  color: Theme.of(context).primaryColor,
                  width: isTablet ? 1.sp : 2.sp,
                ),
                fillColor: WidgetStateProperty.all(
                  kit.isChecked
                      ? ColorManager.primary
                      : ColorManager.transparent,
                ),
                checkColor: ColorManager.white,
                value: kit.isChecked,
                onChanged: (_) {
                  locator<KitsCubit>().toggleKitChecked(kit);
                },
              ),
            ),
        
            Gap(isTablet ? 10.w : 0),
        
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
              kit.value.toString().currency,
              style: getBoldStyle(color: color),
            ),
          ],
        );
      },
    );
  }
}
