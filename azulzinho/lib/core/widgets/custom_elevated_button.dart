import 'package:azulzinho/core/utils/constants_manager.dart';
import 'package:azulzinho/themes/color_manager.dart';
import 'package:azulzinho/themes/styles_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomElevatedButton extends StatelessWidget {
  const CustomElevatedButton({
    super.key,
    required this.onPressed,
    required this.text,
    this.width,
    this.height,
    this.backgroundColor,
    this.fontSize,
    this.padding,
  });

  final void Function()? onPressed;
  final String text;
  final double? width;
  final double? height;
  final Color? backgroundColor;
  final double? fontSize;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor ?? ColorManager.primary,
        fixedSize: Size(
          width != null ? width!.w : double.infinity,
          height != null ? height!.h : 50.h,
        ),
        padding: padding ?? EdgeInsets.symmetric(
          horizontal: 10.w,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            ConstantsManager.borderRadius * 1.5,
          ),
        ),
      ),
      onPressed: onPressed,
      child: Text(
        text,
        style: getBoldStyle(color: ColorManager.white).copyWith(
          fontSize: fontSize ?? 18.sp,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}
