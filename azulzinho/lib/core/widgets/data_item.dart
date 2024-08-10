import 'package:azulzinho/core/resources/constants_manager.dart';
import 'package:azulzinho/core/resources/values_manager.dart';
import 'package:azulzinho/core/widgets/data_item_actions_widget.dart';
import 'package:azulzinho/features/calculator/widgets/report/info_item.dart';
import 'package:azulzinho/themes/color_manager.dart';
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
        horizontal: AppPadding.p14.w,
        vertical: AppPadding.p14.h,
      ),
      decoration: _decorate(),
      child: Column(
        children: [
          InfoItem(label: name, value: value),
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
      child: Divider(
        thickness: 2.sp,
      ),
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
