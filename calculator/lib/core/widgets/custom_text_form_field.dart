import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    super.key,
    required this.labelText,
    this.onChanged,
    this.controller,
    this.formKey,
    this.keyboardType = TextInputType.number,
  });

  final String labelText;
  final void Function(String)? onChanged;
  final TextEditingController? controller;
  final Key? formKey;
  final TextInputType? keyboardType;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      key: formKey,
      controller: controller,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: const TextStyle(
          color: Colors.black,
        ),
        enabledBorder: decorateBorder(),
        focusedBorder: decorateBorder(),
        errorBorder: decorateBorder(),
        disabledBorder: decorateBorder(),
      ),
      onChanged: onChanged,
    );
  }
}

OutlineInputBorder decorateBorder() {
  return OutlineInputBorder(
    borderRadius: BorderRadius.circular(15),
    borderSide: const BorderSide(
      color: Colors.blue,
      width: 2,
    ),
  );
}
