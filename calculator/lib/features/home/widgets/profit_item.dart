import 'package:calculator/app/resources/color_manager.dart';
import 'package:calculator/app/utils/functions.dart';
import 'package:flutter/material.dart';

class ProfitItem extends StatelessWidget {
  const ProfitItem({
    super.key,
    required this.profitId,
    required this.value,
    required this.profitValue,
    required this.onChanged,
  });

  final String profitId;
  final double profitValue;
  final bool value;
  final void Function(bool?)? onChanged;

  @override
  Widget build(BuildContext context) {
    Color color = value ? ColorManager.lightGrey : ColorManager.black;
    return Row(
      children: [
        Transform.scale(
          scale: 1.3,
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
          profitId,
          style: getTextStyle().copyWith(
            color: color,
          ),
        ),
        const Spacer(),
        Text(
          '$profitValue',
          style: getTextStyle(),
        ),
      ],
    );
  }
}
