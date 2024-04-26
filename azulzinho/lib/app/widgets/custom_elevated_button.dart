import 'package:azulzinho/app/resources/color_manager.dart';
import 'package:azulzinho/app/resources/constants_manager.dart';
import 'package:azulzinho/app/resources/styles_manager.dart';
import 'package:flutter/material.dart';

class CustomElevatedButton extends StatelessWidget {
  const CustomElevatedButton({
    super.key,
    required this.onPressed,
    required this.text,
    this.width,
    this.textStyle,
    this.style,
  });

  final void Function()? onPressed;
  final String text;
  final double? width;
  final TextStyle? textStyle;
  final ButtonStyle? style;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.sizeOf(context).width * 0.13,
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
          style:textStyle ??  TextStylesManager.textStyle26.copyWith(
            color: ColorManager.white,
            fontWeight: FontWeight.w700,
            
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
