import 'package:calculator/app/resources/color_manager.dart';
import 'package:calculator/app/resources/constants_manager.dart';
import 'package:calculator/app/resources/strings_manager.dart';
import 'package:calculator/app/resources/styles_manager.dart';
import 'package:calculator/app/resources/values_manager.dart';
import 'package:calculator/app/utils/dependency_injection.dart';
import 'package:calculator/app/utils/functions.dart';
import 'package:calculator/app/widgets/custom_icon_button.dart';
import 'package:calculator/app/widgets/custom_text_form_field.dart';
import 'package:calculator/features/kits/kit_cubit/kit_cubit.dart';
import 'package:calculator/features/persons/person_cubit/persons_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';

class AddItemWidget extends StatelessWidget {
  AddItemWidget({
    super.key,
    this.labelInputType,
    this.labelInputFormatters,
  });

  // cubits
  final PersonsCubit personsCubit = locator<PersonsCubit>();
  final KitsCubit profitsCubit = locator<KitsCubit>();

  // controllers
  final TextEditingController nameController = TextEditingController();
  final TextEditingController valueController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  // input properties
  final TextInputType? labelInputType;
  final List<TextInputFormatter>? labelInputFormatters;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // item title
        Container(
          margin: const EdgeInsets.only(left: AppPadding.p5),
          child: const Text(
            PersonsStrings.addPerson,
            style: TextStylesManager.textStyle28,
          ),
        ),

        const Gap(10),

        // item form
        Form(
          key: _formKey,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // item lable
              Expanded(
                flex: 3,
                child: CustomTextFormField(
                  controller: nameController,
                  fontWeight: FontWeight.normal,
                  labelText: StringsManager.name,
                  keyboardType: labelInputType,
                  inputFormatters: labelInputFormatters,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return StringsManager.enterName;
                    }
                    return null;
                  },
                ),
              ),

              const Gap(10),

              // item value
              Expanded(
                flex: 3,
                child: CustomTextFormField(
                  controller: valueController,
                  fontWeight: FontWeight.normal,
                  labelText: PersonsStrings.percentage,
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                  inputFormatters:
                      getInputFormatters(ConstantsManager.valueRegex),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return PersonsStrings.enterPercentage;
                    }
                    return null;
                  },
                ),
              ),

              const Gap(10),

              // add button
              CustomIconButton(
                icon: const FaIcon(FontAwesomeIcons.plus),
                height: MediaQuery.of(context).size.width * 0.156,
                width: MediaQuery.of(context).size.width * 0.12,
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(
                    ColorManager.primary,
                  ),
                  iconColor: MaterialStateProperty.all(
                    ColorManager.white,
                  ),
                ),
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    await personsCubit.addPerson(
                      name: nameController.text,
                      percentage: double.parse(valueController.text),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}
