import 'package:azulzinho/core/resources/color_manager.dart';
import 'package:azulzinho/core/resources/constants_manager.dart';
import 'package:azulzinho/core/resources/styles_manager.dart';
import 'package:azulzinho/core/resources/values_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AddItemWidget extends StatelessWidget {
  const AddItemWidget({
    super.key,
    this.color,
    required this.onTap,
    required this.text,
  });

  final Color? color;
  final void Function()? onTap;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: color ?? ColorManager.primary,
        borderRadius: BorderRadius.circular(ConstantsManager.borderRadius),
      ),
      padding: EdgeInsets.symmetric(
        horizontal: AppPadding.p14.w,
      ),
      height: 0.09.sh,
      child: InkWell(
        highlightColor: ColorManager.transparent,
        onTap: onTap,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              text,
              style: TextStylesManager.textStyle22.copyWith(
                color: ColorManager.white,
                fontWeight: FontWeight.w600,
              ),
            ),

            // arrow
            FaIcon(
              FontAwesomeIcons.angleRight,
              color: ColorManager.white,
              size: AppSize.s32,
            ),
          ],
        ),
      ),
    );
  }
}
