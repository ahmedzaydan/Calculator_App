import 'package:azulzinho/core/resources/constants_manager.dart';
import 'package:azulzinho/themes/color_manager.dart';
import 'package:azulzinho/themes/styles_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AddListTile extends StatelessWidget {
  const AddListTile({
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
        trailing: FaIcon(
          FontAwesomeIcons.chevronRight,
          color: ColorManager.white,
          size: ConstantsManager.iconSize * 0.8,
        ),
        contentPadding: EdgeInsets.only(
          left: 10.w,
          right: 15.w,
          top: isTablet ? 5 : 0,
          bottom: isTablet ? 5 : 0,
        ),
      ),
    );
  }
}
