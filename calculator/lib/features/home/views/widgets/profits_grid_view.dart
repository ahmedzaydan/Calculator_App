import 'package:flutter/material.dart';

class ProfitsGridView extends StatelessWidget {
  const ProfitsGridView({
    super.key,
    required this.itemsCount,
    required this.itemBuilder,
  });

  final int itemsCount;
  final Widget? Function(BuildContext, int) itemBuilder;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: itemsCount,
      scrollDirection: Axis.vertical,
      itemBuilder: itemBuilder,
    );
  }
}
