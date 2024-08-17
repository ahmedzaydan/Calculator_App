import 'package:azulzinho/core/utils/constants_manager.dart';
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
    this.onActionPressed,
    this.deleteOnPressed,
    this.isActionVisible = true,
    this.isDeleteVisible = true,
    this.actionIcon = FontAwesomeIcons.pen,
  });

  final Color? color;
  final String name;
  final String value;
  final void Function()? onActionPressed;
  final void Function()? deleteOnPressed;
  final bool isActionVisible;
  final bool isDeleteVisible;
  final IconData actionIcon;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: color ?? ColorManager.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(
          ConstantsManager.borderRadius,
        ),
        side: BorderSide(
          color: ColorManager.black,
          width: 1.sp,
        ),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 20.w,
          vertical: 14.h,
        ),
        child: Column(
          children: [
            InfoItem(label: name, value: value),

            if (isDeleteVisible || isActionVisible) ...[
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
                if (isActionVisible)
                  CustomIconButton(
                    onPressed: onActionPressed,
                    faIcon: FaIcon(
                      actionIcon,
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
      ),
    );
  }
}
