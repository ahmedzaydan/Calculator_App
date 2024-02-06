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
  });

  final Key? formKey;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final String? labelText;
  final String? hintText;
  final void Function(String)? onChanged;
  final String? Function(String?)? validator;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      cursorColor: Theme.of(context).primaryColor,
      key: formKey,
      controller: controller,
      keyboardType: keyboardType,
      inputFormatters: inputFormatters,
      decoration: InputDecoration(
        hintText: hintText,
        labelText: labelText,
      ),
      onChanged: onChanged,
      validator: validator,
    );
  }
}
