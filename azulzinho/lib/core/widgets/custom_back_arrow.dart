import 'package:azulzinho/core/resources/constants_manager.dart';
import 'package:azulzinho/core/widgets/custom_icon_button.dart';
import 'package:azulzinho/themes/color_manager.dart';
import 'package:flutter/material.dart';

class CustomBackArrow extends StatelessWidget {
  const CustomBackArrow(this.sourceContext, {super.key});

  final BuildContext sourceContext;

  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
      angle: 3.14,
      child: CustomIconButton(
        icon: Icon(Icons.arrow_forward_ios),
        onPressed: () {
          Navigator.pop(sourceContext);
          // unFocus
          FocusScope.of(context).unfocus();
        },
        style: ButtonStyle(
          padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
            EdgeInsets.all(0),
          ),
          iconColor: MaterialStateProperty.all<Color>(
            ColorManager.white,
          ),
          iconSize: MaterialStateProperty.all<double>(
            ConstantsManager.iconSize * 0.8,
          ),
        ),
      ),
    );
  }
}
