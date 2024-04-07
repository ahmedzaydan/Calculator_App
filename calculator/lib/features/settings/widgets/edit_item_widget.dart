import 'package:calculator/app/resources/font_manager.dart';
import 'package:calculator/app/widgets/custom_icon_button.dart';
import 'package:calculator/app/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class EditItemWidget extends StatelessWidget {
  const EditItemWidget({
    super.key,
    required this.value,
    required this.name,
    required this.onChanged,
    required this.deleteOnPressed,
  });

  final String name;
  final double value;
  final Function(String)? onChanged;
  final void Function()? deleteOnPressed;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: CustomTextFormField(
            controller: TextEditingController(
              text: '$value',
            ),
            labelText: name,
            fontSize: FontSize.s22,
            // inputFormatters: getInputFormatters(),
            onChanged: onChanged,
            // onChanged: (value) {
            //   // kprint(value.runtimeType);
            //   // kprint(value);
            // },
          ),
        ),

        const Gap(10),

        // delete person button
        CustomIconButton(
          onPressed: deleteOnPressed,
          icon: const Icon(Icons.delete),
        ),
      ],
    );
  }
}
