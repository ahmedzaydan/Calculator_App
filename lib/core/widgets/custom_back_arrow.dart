import 'package:azulzinho/core/utils/constants_manager.dart';
import 'package:azulzinho/core/widgets/custom_icon_button.dart';
import 'package:azulzinho/themes/color_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CustomBackArrow extends StatelessWidget {
  const CustomBackArrow({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomIconButton(
      faIcon: FaIcon(
        FontAwesomeIcons.chevronLeft,
        size: 24.sp,
      ),
      onPressed: () {
        Navigator.pop(context);
        FocusScope.of(context).unfocus();
      },
      style: ButtonStyle(
        padding: WidgetStateProperty.all<EdgeInsetsGeometry>(
          EdgeInsets.only(
            top: 0,
            bottom: 0,
            right: 0,
            left: isTablet ? 10.w : 0,
          ),
        ),
        iconColor: WidgetStateProperty.all<Color>(
          ColorManager.white,
        ),
        iconSize: WidgetStateProperty.all<double>(
          ConstantsManager.iconSize * 0.8,
        ),
      ),
    );
  }
}
