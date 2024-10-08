import 'package:azulzinho/themes/strings_manager.dart';
import 'package:azulzinho/themes/color_manager.dart';
import 'package:azulzinho/themes/styles_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({
    super.key,
    this.message = StringsManager.loading,
  });

  final String message;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 18.w),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(
              color: ColorManager.primary,
            ),
            SizedBox(height: 20.h),
            Text(
              message,
              style: getBoldStyle(),
              textAlign: TextAlign.center,
              softWrap: true,
            ),
          ],
        ),
      ),
    );
  }
}
