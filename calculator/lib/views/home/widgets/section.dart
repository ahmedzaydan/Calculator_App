import 'package:calculator/core/widgets/custom_elevated_button.dart';
import 'package:calculator/core/widgets/custom_list_view.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class Section extends StatelessWidget {
  const Section({
    super.key,
    required this.itemCount,
    required this.itemBuilder,
    this.addOnPressed,
    required this.addText,
    this.deleteOnPressed,
    required this.deleteText,
  });

  final int itemCount;
  final Widget? Function(BuildContext, int) itemBuilder;

  final void Function()? addOnPressed;
  final String addText;

  final void Function()? deleteOnPressed;
  final String deleteText;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // fields
        CustomListView(
          itemBuilder: itemBuilder,
          itemCount: itemCount,
        ),
        
        const Gap(20),

        Row(
          children: [
            // add field button
            Expanded(
              child: CustomElevatedButton(
                onPressed: addOnPressed,
                text: addText,
              ),
            ),

            const Gap(10),

            // delete field button
            Expanded(
              child: CustomElevatedButton(
                onPressed: deleteOnPressed,
                text: deleteText,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
