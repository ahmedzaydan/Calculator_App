import 'package:calculator/app/resources/color_manager.dart';
import 'package:calculator/app/resources/constants_manager.dart';
import 'package:calculator/app/resources/font_manager.dart';
import 'package:calculator/app/resources/strings_manager.dart';
import 'package:calculator/app/resources/values_manager.dart';
import 'package:calculator/app/utils/dependency_injection.dart';
import 'package:calculator/app/utils/functions.dart';
import 'package:calculator/app/widgets/custom_elevated_button.dart';
import 'package:calculator/app/widgets/custom_icon_button.dart';
import 'package:calculator/app/widgets/custom_text_form_field.dart';
import 'package:calculator/features/kits/kit_cubit/kit_cubit.dart';
import 'package:calculator/features/persons/person_cubit/persons_cubit.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class EditItemView extends StatelessWidget {
  EditItemView({
    super.key,
    required this.label,
    required this.value,
    required this.sourceContext,
    this.updateKits = false,
    required this.index,
  });

  final String label;
  final double value;
  final int index;
  final bool updateKits;
  final BuildContext sourceContext;

  final TextEditingController valueController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    valueController.text = value.toString();

    return Scaffold(
      appBar: AppBar(
        leading: CustomIconButton(
          style: ButtonStyle(
            iconColor: MaterialStateProperty.all(ColorManager.white),
          ),
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () => Navigator.pop(sourceContext),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: AppPadding.p50,
          horizontal: AppPadding.p20,
        ),
        child: Column(
          children: [
            CustomTextFormField(
              controller: valueController,
              labelText: label,
              fontSize: FontSize.s22,
              inputFormatters: getInputFormatters(ConstantsManager.valueRegex),
            ),
            const Gap(30),
            CustomElevatedButton(
              onPressed: () async {
                if (updateKits) {
                  await locator<KitsCubit>().updateKitValue(
                    index: index,
                    value: double.parse(valueController.text),
                  );
                } else {
                  await locator<PersonsCubit>().updatePersonPercentage(
                    index: index,
                    value: double.parse(valueController.text),
                  );
                }
                if (sourceContext.mounted) {
                  Navigator.pop(sourceContext);
                }
              },
              text: StringsManager.save,
              width: double.infinity,
            )
          ],
        ),
      ),
    );
  }
}
