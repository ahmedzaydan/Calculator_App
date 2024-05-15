import 'package:azulzinho/core/resources/color_manager.dart';
import 'package:azulzinho/core/resources/constants_manager.dart';
import 'package:azulzinho/core/resources/styles_manager.dart';
import 'package:azulzinho/core/resources/values_manager.dart';
import 'package:azulzinho/core/widgets/custom_divider.dart';
import 'package:azulzinho/core/widgets/data_item_actions_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DataItem extends StatelessWidget {
  const DataItem({
    super.key,
    this.color,
    required this.name,
    required this.value,
    this.editOnPressed,
    this.deleteOnPressed,
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
      padding: EdgeInsets.symmetric(
        horizontal: AppPadding.p20.w,
        vertical: AppPadding.p20.h,
      ),
      decoration: _decorate(),
      child: Column(
        children: [
          NameAndValue(
            name: name,
            value: value,
          ),
          if (isDeleteVisible || isEditVisible) _divider(),
          DataItemActionsWidget(
            editOnPressed: editOnPressed,
            deleteOnPressed: deleteOnPressed,
            isEditVisible: isEditVisible,
            isDeleteVisible: isDeleteVisible,
          ),
        ],
      ),
    );
  }

  Padding _divider() {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: AppPadding.p10.h,
      ),
      child: CustomDivider(thickness: 2.1.sp),
    );
  }

  BoxDecoration _decorate() {
    return BoxDecoration(
      border: Border.all(
        color: ColorManager.black,
        width: 1.5.sp,
      ),
      borderRadius: BorderRadius.circular(
        ConstantsManager.borderRadius,
      ),
      color: color ?? ColorManager.transparent,
    );
  }
}

class NameAndValue extends StatelessWidget {
  const NameAndValue({
    super.key,
    required this.name,
    required this.value,
  });

  final String name;
  final String value;

  @override
  Widget build(BuildContext context) {
    final TextStyle style = TextStylesManager.textStyle26.copyWith(
      fontWeight: FontWeight.w600,
      color: ColorManager.black,
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
