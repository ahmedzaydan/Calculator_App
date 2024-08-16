import 'package:azulzinho/core/utils/functions.dart';
import 'package:azulzinho/core/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';

import '../../../themes/color_manager.dart';

class DateInputField extends StatelessWidget {
  const DateInputField({
    super.key,
    required this.controller,
    required this.label,
    this.validator,
    required this.onDateSelected,
  });

  final TextEditingController controller;
  final String label;
  final String? Function(String?)? validator;
  final void Function(DateTime date) onDateSelected;

  @override
  Widget build(BuildContext context) {
    return CustomTextFormField(
      controller: controller,
      labelText: label,
      hintText: getDateAsString(),
      keyboardType: TextInputType.datetime,
      readOnly: true,
      onTap: () async {
        var date = await showDatePicker(
          builder: (context, child) {
            return Theme(
              data: ThemeData.light().copyWith(
                colorScheme: ColorScheme.light(
                  primary: ColorManager.primary,
                  onSurface: ColorManager.black,
                ),
                buttonTheme: ButtonThemeData(
                  colorScheme: ColorScheme.light(
                    primary: ColorManager.red,
                  ),
                ),
              ),
              child: child!,
            );
          },
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime(2000),
          lastDate: DateTime(2100),
        );

        // If the user selects a date
        if (date != null) {
          onDateSelected(date);
          controller.text = getDateAsString(
            date: getFormattedDate(date: date),
          );
        }
      },
      validator: validator,
    );
  }
}
