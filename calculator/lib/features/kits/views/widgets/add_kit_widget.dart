import 'package:calculator/app/resources/strings_manager.dart';
import 'package:calculator/app/utils/functions.dart';
import 'package:calculator/features/settings/widgets/add_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class AddKitWidget extends StatelessWidget {
  const AddKitWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          StringsManager.addKit,
          style: getTextStyle(),
        ),
        const Gap(20),
        AddItemWidget(
          name: StringsManager.kitNumber,
          nameValidator: StringsManager.enterNumber,
          value: StringsManager.kitValue,
          valueValidator: StringsManager.enterValue,
          inputType: TextInputType.number,
        ),
      ],
    );
  }
}
