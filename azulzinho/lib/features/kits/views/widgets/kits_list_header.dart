import 'package:azulzinho/app/resources/styles_manager.dart';
import 'package:azulzinho/app/resources/values_manager.dart';
import 'package:azulzinho/app/widgets/collapse_button.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class KitsListHeader extends StatelessWidget {
  const KitsListHeader({
    super.key,
    required this.title,
    required this.counter,
    required this.collapseButton,
  });

  final String title;
  final String counter;
  final CollapseButton collapseButton;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          title,
          style: TextStylesManager.textStyle28,
        ),
        const Gap(15),
        const Spacer(),
        Text(
          counter,
          style: TextStylesManager.textStyle24.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(
            left: AppPadding.p20,
          ),
          child: collapseButton,
        ),
      ],
    );
  }
}
