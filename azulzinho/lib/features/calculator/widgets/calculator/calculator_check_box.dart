import 'package:azulzinho/core/resources/constants_manager.dart';
import 'package:azulzinho/features/kits/kit_cubit/kit_cubit.dart';
import 'package:azulzinho/features/kits/models/kit_model.dart';
import 'package:azulzinho/themes/color_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/utils/dependency_injection.dart';

class CalculatorCheckBox extends StatelessWidget {
  const CalculatorCheckBox({
    super.key,
    required this.kit,
  });

  final KitModel kit;

  @override
  Widget build(BuildContext context) {
    return Transform.scale(
      scale: 1.sp,
      child: Checkbox(
        visualDensity: VisualDensity.compact,
        side: BorderSide(
          color: Theme.of(context).primaryColor,
          width: isTablet ? 1.sp : 2.sp,
        ),
        fillColor: WidgetStateProperty.all(
          kit.isChecked ? ColorManager.primary : ColorManager.transparent,
        ),
        checkColor: ColorManager.white,
        value: kit.isChecked,
        onChanged: (_) async {
          await locator<KitsCubit>().toggleKitChecked(kit);
        },
      ),
    );
  }
}
