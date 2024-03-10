import 'package:calculator/core/calculator_cubit/calculator_cubit.dart';
import 'package:calculator/core/utils/functions.dart';
import 'package:calculator/core/resources/strings_manager.dart';
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
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              StringsManager.note,
              style: getTextStyle(),
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
                style: getTextStyle().copyWith(),
              ),
            ),
          ),
        ],
      ],
    );
  }
}