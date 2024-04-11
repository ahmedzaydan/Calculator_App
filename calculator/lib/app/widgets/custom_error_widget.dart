import 'package:calculator/app/resources/color_manager.dart';
import 'package:calculator/app/resources/styles_manager.dart';
import 'package:calculator/app/resources/values_manager.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CustomErrorWidget extends StatelessWidget {
  const CustomErrorWidget(this.message, {super.key});

  final String message;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppPadding.p20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            FaIcon(
              FontAwesomeIcons.triangleExclamation,
              color: ColorManager.red,
              size: 50,
            ),
            const SizedBox(height: 20),
            Text(
              message,
              style: TextStylesManager.textStyle28,
              softWrap: true,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
