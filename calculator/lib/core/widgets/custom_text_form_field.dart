import 'package:calculator/core/resources/constants_manager.dart';
import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    super.key,
    this.labelText,
    this.onChanged,
    this.controller,
    this.formKey,
    this.keyboardType = TextInputType.number,
    this.validator,
    this.hintText,
    this.enabled = true,
  });

  final String? labelText;
  final String? hintText;
  final void Function(String)? onChanged;
  final TextEditingController? controller;
  final Key? formKey;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;
  final bool enabled;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      key: formKey,
      enabled: enabled,
      controller: controller,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        hintText: hintText,
        labelText: labelText,
        labelStyle: const TextStyle(
          color: Colors.black,
        ),
        enabledBorder: decorateBorder(),
        focusedBorder: decorateBorder(),
        errorBorder: decorateBorder(),
        focusedErrorBorder: decorateBorder(),
        disabledBorder: decorateBorder(),
        border: decorateBorder(),
      ),
      onChanged: onChanged,
      validator: validator,
    );
  }
}

OutlineInputBorder decorateBorder() {
  return OutlineInputBorder(
    borderRadius: BorderRadius.circular(ConstantsManager.borderRadius),
    borderSide: const BorderSide(
      color: Colors.blue,
      width: 2,
    ),
  );
}
