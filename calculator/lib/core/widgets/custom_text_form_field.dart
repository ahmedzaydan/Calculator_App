import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
    this.inputFormatters,
  });

  final String? labelText;
  final String? hintText;
  final void Function(String)? onChanged;
  final TextEditingController? controller;
  final Key? formKey;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;
  final bool enabled;
  final List<TextInputFormatter>? inputFormatters;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      cursorColor: Theme.of(context).primaryColor,
      key: formKey,
      enabled: enabled,
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
