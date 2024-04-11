import 'package:calculator/app/resources/strings_manager.dart';
import 'package:calculator/app/resources/styles_manager.dart';
import 'package:calculator/app/utils/functions.dart';
import 'package:calculator/features/calculator/calculator_cubit/calculator_cubit.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class Note extends StatelessWidget {
  const Note({super.key, required this.cubit});

  final CalculatorCubit cubit;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (cubit.note.isNotEmpty) ...[
          // note title
          const Align(
            alignment: Alignment.centerLeft,
            child: Text(
              CalculatorStrings.note,
              style: TextStylesManager.textStyle28,
            ),
          ),

          const Gap(10),

          // note body
          Container(
            padding: const EdgeInsets.all(10),
            width: double.infinity,
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.grey,
                width: 2,
              ),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Directionality(
              textDirection: getTextDirection(cubit.note),
              child: Text(
                cubit.note,
                style: TextStylesManager.textStyle24,
              ),
            ),
          ),
        ],
      ],
    );
  }
}
