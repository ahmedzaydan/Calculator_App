import 'package:azulzinho/core/resources/constants_manager.dart';
import 'package:azulzinho/themes/color_manager.dart';
import 'package:azulzinho/themes/styles_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomListTile extends StatelessWidget {
  const CustomListTile({
    super.key,
    required this.onTap,
    required this.text,
  });

  final void Function()? onTap;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          ConstantsManager.borderRadius,
        ),
        color: ColorManager.primary,
      ),
      child: ListTile(
        onTap: onTap,
        title: Text(
          text,
          style: getBoldStyle(color: ColorManager.white),
        ),
        trailing: Icon(
          Icons.arrow_forward_ios,
          color: ColorManager.white,
          size: ConstantsManager.iconSize * 0.8,
        ),
        contentPadding: EdgeInsets.only(
          left: 10.w,
          right: 10.w,
        ),
      ),
    );
  }
}
