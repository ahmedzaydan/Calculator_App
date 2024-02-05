import 'package:calculator/core/widgets/custom_icon_button.dart';
import 'package:calculator/core/widgets/custom_text_form_field.dart';
import 'package:calculator/core/cubit/calculator_cubit.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class EditProfit extends StatelessWidget {
  const EditProfit({
    super.key,
    required this.cubit,
    required this.profitKey,
    required this.index,
  });

  final CalculatorCubit cubit;
  final String profitKey;
  final int index;
// TODO: combine profit and person widgets together
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: CustomTextFormField(
            controller: TextEditingController(
              text: cubit.profits[profitKey].toString(),
            ),
            labelText: profitKey,
            onChanged: (value) {
              cubit.profits[profitKey] = double.parse(value);
            },
          ),
        ),

        const Gap(10),

        // delete person button
        CustomIconButton(
          onPressed: () async {
            await cubit.deleteProfitItem(profitId: profitKey);
          },
          icon: const Icon(
            Icons.delete
          ),
        ),
      ],
    );
  }
}
