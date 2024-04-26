import 'package:azulzinho/app/resources/values_manager.dart';
import 'package:azulzinho/app/utils/functions.dart';
import 'package:flutter/material.dart';

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
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(
              AppPadding.p20,
            ),
            child: child,
          ),
        ),
      ),
    );
  }
}
