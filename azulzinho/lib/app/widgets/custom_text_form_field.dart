import 'package:azulzinho/app/resources/color_manager.dart';
import 'package:azulzinho/app/resources/constants_manager.dart';
import 'package:azulzinho/app/resources/font_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
    this.fontSize = FontSize.s20,
    this.readOnly = false,
    this.onTap,
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
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onTap: onTap,
      readOnly: readOnly,
      cursorColor: Theme.of(context).primaryColor,
      key: formKey,
      controller: controller,
      keyboardType: keyboardType,
      inputFormatters: inputFormatters,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(
          color: ColorManager.lightGrey,
        ),
        labelText: labelText,
        labelStyle: TextStyle(
          fontSize: fontSize,
          color: ColorManager.black,
          fontWeight: fontWeight,
        ),
        enabledBorder: _decorateBorder(color: ColorManager.lightGrey),
        focusedBorder: _decorateBorder(color: ColorManager.primary),
        errorBorder: _decorateBorder(color: ColorManager.red),
        focusedErrorBorder: _decorateBorder(color: ColorManager.red),
        disabledBorder: _decorateBorder(color: ColorManager.black),
        border: _decorateBorder(color: ColorManager.black),
      ),
      onChanged: onChanged,
      validator: validator,
    );
  }
}

OutlineInputBorder _decorateBorder({Color? color}) {
  return OutlineInputBorder(
    borderRadius: BorderRadius.circular(
      ConstantsManager.borderRadius,
    ),
    borderSide: BorderSide(
      color: color ?? ColorManager.primary,
      width: 2,
    ),
  );
}
