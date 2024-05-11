import 'package:azulzinho/app/resources/constants_manager.dart';
import 'package:azulzinho/app/resources/strings_manager.dart';
import 'package:azulzinho/app/utils/extensions.dart';
import 'package:azulzinho/app/utils/functions.dart';
import 'package:azulzinho/app/widgets/add_or_update_cancel_widget.dart';
import 'package:azulzinho/app/widgets/add_view.dart';
import 'package:azulzinho/app/widgets/custom_text_form_field.dart';
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
    return AddView(
      title: KitsStrings.addKit,
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
        } else if (value.isNotEmpty) {
          // Check if the kit number already exists
          // TODO: perform the same logic in person form validator
          if (locator<KitsCubit>()
              .kits
              .any((element) => element.name == value)) {
            return KitsStrings.kitExists;
          }
        }
        return null;
      },
    );
  }

  CustomTextFormField _kitValue() {
    return CustomTextFormField(
      controller: _kitValueController,
      fontWeight: FontWeight.normal,
      labelText: KitsStrings.kitValue,
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
    _startDateController.text = getDateAsString();

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
          locator<KitsCubit>().selectedDate = getFormattedDate(date: date);
          _startDateController.text =
              getDateAsString(date: getFormattedDate(date: date));
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
    return AddUpdateCancelWidget(
      onPressed: () async {
        var kitsCubit = locator<KitsCubit>();
        if (_formKey.currentState!.validate()) {
          kitsCubit
              .createKit(
            name: _kitNameController.text,
            value: _kitValueController.text.toDouble(),
          )
              .then(
            (response) {
              if (response == true && sourceContext.mounted) {
                Navigator.pop(sourceContext);
              }
            },
          );
        }
      },
      actionText: KitsStrings.add,
      sourceContext: sourceContext,
    );
  }
}
