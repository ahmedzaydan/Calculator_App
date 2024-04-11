import 'package:calculator/app/resources/color_manager.dart';
import 'package:calculator/app/resources/styles_manager.dart';
import 'package:flutter/material.dart';

class KitWithCheckbox extends StatelessWidget {
  const KitWithCheckbox({
    super.key,
    required this.kitName,
    required this.value,
    required this.kitValue,
    required this.onChanged,
  });

  final String kitName;
  final double kitValue;
  final bool value;
  final void Function(bool?)? onChanged;

  @override
  Widget build(BuildContext context) {
    Color color = value ? ColorManager.lightGrey : ColorManager.black;
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
              value ? ColorManager.primary : ColorManager.transparent,
            ),
            checkColor: ColorManager.white,
            value: value,
            onChanged: onChanged,
          ),
        ),
        Text(
          kitName,
          style: TextStylesManager.textStyle26.copyWith(
            color: color,
          ),
        ),
        const Spacer(),
        Text(
          '$kitValue',
          style: TextStylesManager.textStyle26.copyWith(
            color: color,
          ),
        ),
      ],
    );
  }
}
