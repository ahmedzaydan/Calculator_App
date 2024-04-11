import 'package:calculator/app/resources/strings_manager.dart';
import 'package:calculator/app/utils/functions.dart';
import 'package:flutter/material.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({
    super.key,
    this.message = StringsManager.loading,
  });

  final String message;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const CircularProgressIndicator(
          color: Colors.blue,
        ),
        const SizedBox(height: 20),
        Text(
          message,
          style: getTextStyle(),
        ),
      ],
    );
  }
}
