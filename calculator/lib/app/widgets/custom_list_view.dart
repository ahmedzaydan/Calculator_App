import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class CustomListView extends StatelessWidget {
  const CustomListView({
    super.key,
    required this.itemBuilder,
    this.separatorBuilder,
    required this.itemCount,
  });

  final Widget? Function(BuildContext, int) itemBuilder;
  final Widget Function(BuildContext, int)? separatorBuilder;
  final int itemCount;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: itemBuilder,
      separatorBuilder: separatorBuilder ?? (context, index) => const Gap(10),
      itemCount: itemCount,
    );
  }
}
