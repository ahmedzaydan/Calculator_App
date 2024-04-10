import 'package:calculator/app/resources/values_manager.dart';
import 'package:calculator/app/widgets/collapse_button.dart';
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
          style: const TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
          ),
        ),
        const Gap(15),
        const Spacer(),
        Text(
          counter,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
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
