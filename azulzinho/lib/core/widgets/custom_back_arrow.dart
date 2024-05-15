import 'package:azulzinho/core/resources/color_manager.dart';
import 'package:azulzinho/core/resources/values_manager.dart';
import 'package:azulzinho/core/widgets/custom_icon_button.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CustomBackArrow extends StatelessWidget {
  const CustomBackArrow(this.sourceContext, {super.key});

  final BuildContext sourceContext;

  @override
  Widget build(BuildContext context) {
    return CustomIconButton(
      icon: const FaIcon(FontAwesomeIcons.arrowLeft),
      onPressed: () => Navigator.pop(sourceContext),
      style: ButtonStyle(
        iconColor: MaterialStateProperty.all<Color>(ColorManager.white),
        iconSize: MaterialStateProperty.all<double>(AppSize.s32),
      ),
    );
  }
}
