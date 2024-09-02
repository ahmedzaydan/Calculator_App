import 'package:azulzinho/core/utils/constants_manager.dart';
import 'package:azulzinho/themes/color_manager.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AddListTile extends StatelessWidget {
  const AddListTile({
    super.key,
    required this.onTap,
    required this.text,
  });

  final void Function()? onTap;
  final String text;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      title: Text(
        text,
      ),
      tileColor: ColorManager.primary,
      trailing: FaIcon(
        FontAwesomeIcons.chevronRight,
        color: ColorManager.white,
        size: ConstantsManager.iconSize * 0.8,
      ),
    );
  }
}
