import 'package:azulzinho/core/widgets/custom_back_arrow.dart';
import 'package:azulzinho/themes/color_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final double toolbarHeight;
  final List<Widget>? actions;
  final String title;

  CustomAppBar({
    this.toolbarHeight = 70,
    this.actions,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: ColorManager.primary,
      leading: Center(child: CustomBackArrow()),
      title: Text(
        title,
        softWrap: true,
        maxLines: 3,
        overflow: TextOverflow.ellipsis,
      ),
      actions: actions,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(toolbarHeight.h);
}
