import 'package:azulzinho/core/widgets/custom_back_arrow.dart';
import 'package:azulzinho/themes/color_manager.dart';
import 'package:azulzinho/themes/styles_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

AppBar customAppBar({
  required BuildContext context,
  required String title,
  TextStyle? style,
  List<Widget>? actions,
}) {
  return AppBar(
    toolbarHeight: 0.1.sh,
    leading: CustomBackArrow(),
    centerTitle: true,
    title: Text(
      title,
      style: style ?? getRegularStyle(color: ColorManager.white),
      softWrap: true,
      maxLines: 3,
      overflow: TextOverflow.ellipsis,
    ),
    actions: actions,
  );
}
