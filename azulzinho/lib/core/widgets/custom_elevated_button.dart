import 'package:azulzinho/core/resources/constants_manager.dart';
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
  });

  final void Function()? onPressed;
  final String text;
  final double? width;
  final double? height;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor,
        fixedSize: Size(
          width != null ? width!.w : double.infinity,
          height != null ? height!.h : 50.h,
        ),
        padding: EdgeInsets.symmetric(
          horizontal: 10.w,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            ConstantsManager.borderRadius,
          ),
        ),
      ),
      onPressed: onPressed,
      child: Text(
        text,
        style: getBoldStyle(color: ColorManager.white),
        textAlign: TextAlign.center,
      ),
    );
  }
}
