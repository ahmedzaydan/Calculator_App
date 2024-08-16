import 'package:azulzinho/themes/color_manager.dart';
import 'package:azulzinho/themes/styles_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class InfoItem extends StatelessWidget {
  const InfoItem({
    super.key,
    required this.label,
    required this.value,
    this.valueColor,
    this.labelColor,
  });

  final String label;
  final String value;
  final Color? valueColor;
  final Color? labelColor;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            label,
            style: getBoldStyle(
              color: labelColor ?? ColorManager.black,
            ),
            maxLines: 10,
            overflow: TextOverflow.ellipsis,
            softWrap: true,
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: 10.w),
          child: Text(
            value,
            style: getBoldStyle(
              color: valueColor ?? ColorManager.black,
            ),
          ),
        ),
      ],
    );
  }
}
