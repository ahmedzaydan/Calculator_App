import 'package:azulzinho/core/resources/constants_manager.dart';
import 'package:azulzinho/core/resources/values_manager.dart';
import 'package:azulzinho/core/widgets/custom_icon_button.dart';
import 'package:azulzinho/core/widgets/item_widgets/info_item.dart';
import 'package:azulzinho/themes/color_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class DataItem extends StatelessWidget {
  /// Used to show name, value with optional actions
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
      decoration: BoxDecoration(
        border: Border.all(
          color: ColorManager.black,
          width: 1.sp,
        ),
        borderRadius: BorderRadius.circular(
          ConstantsManager.borderRadius * 1.5,
        ),
        color: color ?? ColorManager.transparent,
      ),
      child: Column(
        children: [
          InfoItem(label: name, value: value),

          if (isDeleteVisible || isEditVisible) ...[
            Padding(
              padding: EdgeInsets.only(top: 4.h),
              child: Divider(thickness: 1.5.sp),
            ),
          ],

          // Actions
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Edit button
              if (isEditVisible)
                CustomIconButton(
                  onPressed: editOnPressed,
                  faIcon: FaIcon(
                    FontAwesomeIcons.pen,
                    size: 24.sp,
                  ),
                ),

              // Delete button
              if (isDeleteVisible)
                CustomIconButton(
                  onPressed: deleteOnPressed,
                  faIcon: FaIcon(
                    FontAwesomeIcons.trash,
                    size: 24.sp,
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}
