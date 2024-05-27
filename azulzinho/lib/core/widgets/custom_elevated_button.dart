import 'package:azulzinho/themes/color_manager.dart';
import 'package:azulzinho/core/resources/constants_manager.dart';
import 'package:azulzinho/themes/styles_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomElevatedButton extends StatelessWidget {
  const CustomElevatedButton({
    super.key,
    required this.onPressed,
    required this.text,
    this.width,
    this.textStyle,
    this.style,
    this.height,
  });

  final void Function()? onPressed;
  final String text;
  final double? width;
  final double? height;
  final TextStyle? textStyle;
  final ButtonStyle? style;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height?.h ?? 0.09.sh,
      width: width,
      child: ElevatedButton(
        style: style ??
            ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(
                  ConstantsManager.borderRadius,
                ),
              ),
            ),
        onPressed: onPressed,
        child: Text(
          text,
          style: textStyle ??
              TextStylesManager.textStyle24.copyWith(
                color: ColorManager.white,
                fontWeight: FontWeight.w600,
              ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
