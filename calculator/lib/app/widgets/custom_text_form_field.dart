import 'package:calculator/app/resources/color_manager.dart';
import 'package:calculator/app/resources/font_manager.dart';
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
    this.fontWeight = FontWeight.bold,
    this.fontSize = FontSize.s18,
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

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.width * 0.13,
      child: TextFormField(
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
        ),
        onChanged: onChanged,
        validator: validator,
      ),
    );
  }
}
