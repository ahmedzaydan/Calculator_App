import 'package:calculator/app/resources/color_manager.dart';
import 'package:calculator/app/resources/constants_manager.dart';
import 'package:calculator/app/resources/font_manager.dart';
import 'package:calculator/app/resources/values_manager.dart';
import 'package:calculator/features/widgets/actions_widget.dart';
import 'package:calculator/features/widgets/custom_divider.dart';
import 'package:flutter/material.dart';

class DataItem extends StatelessWidget {
  const DataItem({
    super.key,
    this.color,
    required this.name,
    required this.value,
    required this.editOnPressed,
    required this.deleteOnPressed,
    this.isEditVisible = true,
    this.isDeleteVisible = true,
  });

  final Color? color;
  final String name;
  final String value;
  final void Function()? editOnPressed;
  final void Function()? deleteOnPressed;
  final bool isEditVisible;
  final bool isDeleteVisible;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppPadding.p20),
      decoration: BoxDecoration(
        border: Border.all(
          color: ColorManager.black,
          width: 1.5,
        ),
        borderRadius: BorderRadius.circular(
          ConstantsManager.borderRadius,
        ),
        color: color ?? ColorManager.transparent,
      ),
      child: Column(
        children: [
          NameAndValue(
            name: name,
            value: value,
          ),
          const Padding(
            padding: EdgeInsets.symmetric(
              vertical: AppPadding.p10,
            ),
            child: CustomDivider(),
          ),
          ActionsWidget(
            editOnPressed: editOnPressed,
            deleteOnPressed: deleteOnPressed,
            isEditVisible: isEditVisible,
            isDeleteVisible: isDeleteVisible,
          ),
        ],
      ),
    );
  }
}

class NameAndValue extends StatelessWidget {
  const NameAndValue({
    super.key,
    required this.name,
    required this.value,
    this.textColor,
  });

  final String name;
  final String value;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    final TextStyle style = TextStyle(
      fontSize: FontSize.s24,
      fontWeight: FontWeight.bold,
      color: textColor ?? ColorManager.black,
    );

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // name
        Text(
          name,
          style: style,
        ),

        // value
        Text(
          value,
          style: style,
        ),
      ],
    );
  }
}
