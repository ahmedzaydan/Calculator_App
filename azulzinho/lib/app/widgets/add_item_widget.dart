import 'package:azulzinho/app/resources/color_manager.dart';
import 'package:azulzinho/app/resources/styles_manager.dart';
import 'package:azulzinho/app/resources/values_manager.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AddItemWidget extends StatelessWidget {
  const AddItemWidget({
    super.key,
    this.color,
    required this.onTap,
    required this.text,
  });

  final Color? color;
  final void Function()? onTap;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: color ?? ColorManager.primary,
        borderRadius: BorderRadius.circular(10),
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: AppPadding.p14,
      ),
      height: MediaQuery.sizeOf(context).height * 0.07,
      child: InkWell(
        highlightColor: ColorManager.transparent,
        onTap: onTap,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              text,
              style: TextStylesManager.textStyle26.copyWith(
                color: ColorManager.white,
                fontWeight: FontWeight.w600,
              ),
            ),

            // arrow
            FaIcon(
              FontAwesomeIcons.angleRight,
              color: ColorManager.white,
              size: 32,
            ),
          ],
        ),
      ),
    );
  }
}
