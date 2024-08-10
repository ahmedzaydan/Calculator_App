import 'package:azulzinho/core/resources/values_manager.dart';
import 'package:azulzinho/core/widgets/custom_app_bar.dart';
import 'package:azulzinho/themes/styles_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AddView extends StatelessWidget {
  AddView({
    super.key,
    required this.child,
    required this.title,
  });

  final Widget child;
  final String title;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: customAppBar(
          context: context,
          title: title,
          style: getBoldStyle(),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: AppPadding.p20.w,
              vertical: AppPadding.p20.h,
            ),
            child: child,
          ),
        ),
      ),
    );
  }
}
