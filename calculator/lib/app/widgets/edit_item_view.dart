import 'package:calculator/app/resources/color_manager.dart';
import 'package:calculator/app/resources/constants_manager.dart';
import 'package:calculator/app/resources/font_manager.dart';
import 'package:calculator/app/resources/strings_manager.dart';
import 'package:calculator/app/resources/values_manager.dart';
import 'package:calculator/app/utils/dependency_injection.dart';
import 'package:calculator/app/utils/extensions.dart';
import 'package:calculator/app/utils/functions.dart';
import 'package:calculator/app/widgets/custom_elevated_button.dart';
import 'package:calculator/app/widgets/custom_icon_button.dart';
import 'package:calculator/app/widgets/custom_text_form_field.dart';
import 'package:calculator/features/kits/kit_cubit/kit_cubit.dart';
import 'package:calculator/features/kits/models/kit_model.dart';
import 'package:calculator/features/persons/person_cubit/persons_cubit.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';

class EditItemView extends StatelessWidget {
  EditItemView({
    super.key,
    required this.label,
    required this.value,
    required this.sourceContext,
    this.updateKits = false,
    // indcates that we are updating admin data
    this.index = -1,
    this.kitModel,
  });

  final String label;
  final double value;
  final int index;
  final bool updateKits;
  final BuildContext sourceContext;
  final KitModel? kitModel;

  final TextEditingController valueController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    valueController.text = value.toString();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          updateKits ? 'Update $label Value' : 'Update $label Percentage',
          style: TextStyle(
            fontSize: FontSize.s24,
            color: ColorManager.white,
          ),
        ),
        leading: CustomIconButton(
          style: ButtonStyle(
            iconColor: MaterialStateProperty.all(ColorManager.white),
          ),
          icon: const FaIcon(FontAwesomeIcons.arrowLeft),
          onPressed: () => Navigator.pop(sourceContext),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: AppPadding.p50,
          horizontal: AppPadding.p20,
        ),
        child: Form(
          key: formKey,
          child: Column(
            children: [
              // value input
              CustomTextFormField(
                controller: valueController,
                labelText: label,
                fontSize: FontSize.s32,
                fontWeight: FontWeight.bold,
                validator: (value) {
                  if (value!.isEmpty) {
                    return updateKits
                        ? StringsManager.enterValue
                        : StringsManager.enterPercentage;
                  }
                  return null;
                },
                inputFormatters:
                    getInputFormatters(ConstantsManager.valueRegex),
              ),

              const Gap(30),

              _actions(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _actions() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // update button
        Expanded(
          child: CustomElevatedButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(
                ColorManager.green,
              ),
            ),
            onPressed: () async {
              var kitsCubit = locator<KitsCubit>();
              if (formKey.currentState!.validate()) {
                if (updateKits) {
                  kitsCubit
                      .updateKit(
                    kitModel: kitModel!,
                    value: valueController.text.toDouble(),
                  )
                      .then((response) {
                    if ((response == null || response == true) &&
                        sourceContext.mounted) {
                      Navigator.pop(sourceContext);
                    }
                  });
                } else {
                  if (index == -1) {
                    // update admin data
                    locator<PersonsCubit>()
                        .updateAdminPercentage(
                      double.parse(valueController.text),
                    )
                        .then(
                      (response) {
                        if ((response == null || response == true) &&
                            sourceContext.mounted) {
                          kprint('update admin percentage success');
                          Navigator.pop(sourceContext);
                        }
                      },
                    );
                  } else {
                    locator<PersonsCubit>()
                        .updatePersonPercentage(
                      index: index,
                      value: double.parse(valueController.text),
                    )
                        .then(
                      (response) {
                        if ((response == null || response == true) &&
                            sourceContext.mounted) {
                          kprint('update person percentage success');
                          Navigator.pop(sourceContext);
                        }
                      },
                    );
                  }
                }
              }
            },
            text: StringsManager.update,
          ),
        ),

        const Gap(20),

        // cancel button
        Expanded(
          child: CustomElevatedButton(
            onPressed: () => Navigator.pop(sourceContext),
            text: StringsManager.cancel,
          ),
        ),
      ],
    );
  }
}
