import 'package:azulzinho/themes/color_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomExpansionTile extends StatelessWidget {
  const CustomExpansionTile({
    super.key,
    required this.title,
    this.children = const <Widget>[],
    this.trailing,
    this.isExpanded = true,
  });

  final Widget title;
  final List<Widget> children;
  final Widget? trailing;
  final bool isExpanded;

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      initiallyExpanded: isExpanded,
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
      childrenPadding: EdgeInsets.symmetric(
        horizontal: 10.w,
      ),
      minTileHeight: 50.h,
      title: title,
      children: children,
      trailing: trailing,
    );
  }
}
