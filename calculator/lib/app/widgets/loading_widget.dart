import 'package:calculator/app/resources/strings_manager.dart';
import 'package:calculator/app/resources/styles_manager.dart';
import 'package:calculator/app/resources/values_manager.dart';
import 'package:flutter/material.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({
    super.key,
    this.message = StringsManager.loading,
  });

  final String message;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppPadding.p18),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const CircularProgressIndicator(
            color: Colors.blue,
          ),
          const SizedBox(height: 20),
          Text(
            message,
            style: TextStylesManager.textStyle28,
            textAlign: TextAlign.center,
            softWrap: true,
          ),
        ],
      ),
    );
  }
}
