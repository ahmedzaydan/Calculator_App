import 'package:azulzinho/themes/color_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomExpansionTile extends StatelessWidget {
  const CustomExpansionTile({
    super.key,
    required this.title,
    this.children = const <Widget>[],
    this.trailing,
  });

  final Widget title;
  final List<Widget> children;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      backgroundColor: ColorManager.white,
      collapsedBackgroundColor: ColorManager.white,
      tilePadding: EdgeInsets.symmetric(
        horizontal: 0.w,
      ),
      shape: RoundedRectangleBorder(
        side: BorderSide(
          color: ColorManager.transparent,
          width: 1.w,
        ),
      ),
      expansionAnimationStyle: AnimationStyle(
        curve: Curves.easeInOut,
        duration: const Duration(milliseconds: 500),
      ),
      collapsedShape: RoundedRectangleBorder(
        side: BorderSide(
          color: ColorManager.transparent,
          width: 1.w,
        ),
      ),
      childrenPadding: EdgeInsetsDirectional.only(
        start: 0.w,
        end: 10.w,
      ),
      minTileHeight: 50.h,
      title: title,
      children: children,
      trailing: trailing,
    );
  }
}
