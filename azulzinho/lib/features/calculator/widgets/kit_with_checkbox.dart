import 'package:azulzinho/app/resources/color_manager.dart';
import 'package:azulzinho/app/resources/styles_manager.dart';
import 'package:azulzinho/app/utils/functions.dart';
import 'package:azulzinho/features/kits/models/kit_model.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class KitWithCheckbox extends StatelessWidget {
  const KitWithCheckbox({
    super.key,
    required this.kit,
    required this.onChanged,
  });

  final KitModel kit;
  final void Function(bool?)? onChanged;

  @override
  Widget build(BuildContext context) {
    Color color = kit.isChecked ? ColorManager.lightGrey : ColorManager.black;
    return Row(
      children: [
        Transform.scale(
          scale: 1.6,
          child: Checkbox(
            side: BorderSide(
              color: Theme.of(context).primaryColor,
              width: 2,
            ),
            fillColor: MaterialStateProperty.all(
              kit.isChecked ? ColorManager.primary : ColorManager.transparent,
            ),
            checkColor: ColorManager.white,
            value: kit.isChecked,
            onChanged: onChanged,
          ),
        ),

        // kit name
        Text(
          kit.name,
          style: TextStylesManager.textStyle26.copyWith(
            color: color,
          ),
        ),

        const Gap(5),

        // kit start date
        Text(
          '(${getDateAsString(date: kit.startDate)})',
          style: TextStylesManager.textStyle18.copyWith(
            color: color,
            fontWeight: FontWeight.bold,
          ),
        ),

        const Spacer(),

        // kit value
        Text(
          '${kit.value}',
          style: TextStylesManager.textStyle26.copyWith(
            color: color,
          ),
        ),
      ],
    );
  }
}
