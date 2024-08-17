import 'package:azulzinho/core/utils/constants_manager.dart';
import 'package:azulzinho/themes/color_manager.dart';
import 'package:azulzinho/themes/styles_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    super.key,
    this.labelText,
    this.onChanged,
    this.controller,
    this.formKey,
    this.keyboardType = const TextInputType.numberWithOptions(
      decimal: true,
    ),
    this.validator,
    this.hintText,
    this.inputFormatters,
    this.fontWeight = FontWeight.normal,
    this.fontSize,
    this.readOnly = false,
    this.onTap,
    this.enabled = true,
  });

  final Key? formKey;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final String? labelText;
  final String? hintText;
  final void Function(String)? onChanged;
  final String? Function(String?)? validator;
  final FontWeight fontWeight;
  final double? fontSize;
  final bool readOnly;
  final bool enabled;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onTap: onTap,
      readOnly: readOnly,
      enabled: enabled,
      cursorColor: Theme.of(context).primaryColor,
      key: formKey,
      controller: controller,
      keyboardType: keyboardType,
      inputFormatters: inputFormatters,
      onTapOutside: (value) => FocusScope.of(context).unfocus(),
      style: getMediumStyle(),
      decoration: InputDecoration(
        hintText: hintText,
        contentPadding: EdgeInsets.symmetric(
          vertical: 14.h,
          horizontal: 15.w,
        ),
        hintStyle: getMediumStyle(
          color: ColorManager.lightGrey2,
        ),
        labelText: labelText,
        labelStyle: getMediumStyle(
          color: ColorManager.black,
        ),
        enabledBorder: _decorateBorder(color: ColorManager.lightGrey2),
        focusedBorder: _decorateBorder(color: ColorManager.primary),
        errorBorder: _decorateBorder(color: ColorManager.red),
        focusedErrorBorder: _decorateBorder(color: ColorManager.red),
        disabledBorder: _decorateBorder(color: ColorManager.lightGrey2),
        border: _decorateBorder(color: ColorManager.black),
      ),
      onChanged: onChanged,
      validator: validator,
      onFieldSubmitted: (_) => FocusScope.of(context).unfocus(),
    );
  }
}

OutlineInputBorder _decorateBorder({Color? color}) {
  return OutlineInputBorder(
    borderRadius: BorderRadius.circular(
      ConstantsManager.borderRadius * 1.5,
    ),
    borderSide: BorderSide(
      color: color ?? ColorManager.primary,
      width: 2,
    ),
  );
}
