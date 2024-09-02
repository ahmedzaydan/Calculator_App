import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class CustomListView extends StatelessWidget {
  CustomListView({
    super.key,
    required this.itemBuilder,
    this.separatorBuilder,
    required this.itemCount,
    this.withSeparator = true,
  });

  final Widget? Function(BuildContext, int) itemBuilder;
  final Widget Function(BuildContext, int)? separatorBuilder;
  final int itemCount;
  final bool withSeparator;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: itemBuilder,
      separatorBuilder: separatorBuilder ??
          (context, index) {
            if (withSeparator) {
              return Gap(0);
            }
            return Gap(10.h);
          },
      itemCount: itemCount,
    );
  }
}
