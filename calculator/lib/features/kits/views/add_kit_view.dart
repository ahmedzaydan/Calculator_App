import 'package:calculator/app/resources/constants_manager.dart';
import 'package:calculator/app/resources/strings_manager.dart';
import 'package:calculator/app/resources/values_manager.dart';
import 'package:calculator/app/utils/extensions.dart';
import 'package:calculator/app/utils/functions.dart';
import 'package:calculator/app/widgets/custom_elevated_button.dart';
import 'package:calculator/app/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../app/resources/color_manager.dart';
import '../../../app/utils/dependency_injection.dart';
import '../kit_cubit/kit_cubit.dart';

class AddKitView extends StatelessWidget {
  AddKitView({
    super.key,
    required this.sourceContext,
  });

  final BuildContext sourceContext;

  final TextEditingController _kitNameController = TextEditingController();
  final TextEditingController _kitValueController = TextEditingController();
  final TextEditingController _startDateController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: customAppBar(
          context: context,
          title: KitsStrings.addKit,
        ),
        body: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppPadding.p20),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _kitName(),
                    const Gap(20),

                    _kitValue(),
                    const Gap(20),

                    _timePicker(context),
                    const Gap(20),

                    // add or cancel buttons
                    _actions(),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  CustomTextFormField _kitName() {
    return CustomTextFormField(
      controller: _kitNameController,
      fontWeight: FontWeight.normal,
      labelText: KitsStrings.kitNumber,
      keyboardType: const TextInputType.numberWithOptions(decimal: false),
      inputFormatters: getInputFormatters(ConstantsManager.kitsRegex),
      validator: (value) {
        if (value!.isEmpty) {
          return KitsStrings.enterNumber;
        }
        return null;
      },
    );
  }

  CustomTextFormField _kitValue() {
    return CustomTextFormField(
      controller: _kitValueController,
      fontWeight: FontWeight.normal,
      labelText: KitsStrings.kitNumber,
      keyboardType: const TextInputType.numberWithOptions(decimal: true),
      inputFormatters: getInputFormatters(ConstantsManager.valueRegex),
      validator: (value) {
        if (value!.isEmpty) {
          return KitsStrings.enterValue;
        }
        return null;
      },
    );
  }

  CustomTextFormField _timePicker(BuildContext context) {
    return CustomTextFormField(
      controller: _startDateController,
      labelText: KitsStrings.startDate,
      hintText: getDateAsString(),
      keyboardType: TextInputType.datetime,
      readOnly: true,
      onTap: () async {
        var date = await showDatePicker(
          builder: (context, child) {
            return Theme(
              data: ThemeData.light().copyWith(
                colorScheme: ColorScheme.light(
                  primary: ColorManager.black,
                  onSurface: ColorManager.black,
                ),
                buttonTheme: ButtonThemeData(
                  colorScheme: ColorScheme.light(
                    primary: ColorManager.red,
                  ),
                ),
              ),
              child: child!,
            );
          },
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime(2000),
          lastDate: DateTime(2100),
        );
        if (date != null) {
          _startDateController.text = getDateAsString();
          locator<KitsCubit>().selectedDate = getFormattedDate(date: date);
        }
      },
      validator: (value) {
        if (value!.isEmpty) {
          return KitsStrings.enterStartDate;
        }
        return null;
      },
    );
  }

  Widget _actions() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // add button
        Expanded(
          child: CustomElevatedButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(
                ColorManager.green,
              ),
            ),
            onPressed: () async {
              var kitsCubit = locator<KitsCubit>();
              if (_formKey.currentState!.validate()) {
                kitsCubit
                    .addKit(
                  name: _kitNameController.text,
                  value: _kitValueController.text.toDouble(),
                )
                    .then((response) {
                  if ((response == null || response == true) &&
                      sourceContext.mounted) {
                    Navigator.pop(sourceContext);
                  }
                });
              }
            },
            text: KitsStrings.add,
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
