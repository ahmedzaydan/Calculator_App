import 'package:calculator/core/resources/strings_manager.dart';
import 'package:calculator/core/widgets/custom_elevated_button.dart';
import 'package:flutter/material.dart';

class SaveButton extends StatelessWidget {
  const SaveButton({
    super.key,
    required this.onPressed,
  });

  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: CustomElevatedButton(
        onPressed: onPressed,
        text: StringsManager.save,
      ),
    );
  }
}
