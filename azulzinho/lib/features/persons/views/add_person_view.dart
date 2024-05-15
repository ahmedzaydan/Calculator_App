import 'package:azulzinho/core/resources/constants_manager.dart';
import 'package:azulzinho/core/resources/strings_manager.dart';
import 'package:azulzinho/core/utils/dependency_injection.dart';
import 'package:azulzinho/core/utils/functions.dart';
import 'package:azulzinho/core/widgets/add_or_update_cancel_widget.dart';
import 'package:azulzinho/core/widgets/add_view.dart';
import 'package:azulzinho/core/widgets/custom_text_form_field.dart';
import 'package:azulzinho/features/kits/kit_cubit/kit_cubit.dart';
import 'package:azulzinho/features/persons/person_cubit/persons_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class AddPersonView extends StatelessWidget {
  AddPersonView({
    super.key,
    this.labelInputType,
    this.labelInputFormatters,
    required this.sourceContext,
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

  final BuildContext sourceContext;

  @override
  Widget build(BuildContext context) {
    return AddView(
      title: PersonsStrings.addPerson,
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _personName(),
            Gap(20.h),

            _personPercentage(),
            Gap(20.h),

            // add or cancel buttons
            _actions(),
          ],
        ),
      ),
    );
  }

  Widget _actions() {
    return AddUpdateCancelWidget(
      onPressed: () async {
        if (_formKey.currentState!.validate()) {
          await personsCubit
              .createPerson(
            name: nameController.text,
            percentage: double.parse(valueController.text),
          )
              .then((response) {
            if (response == true && sourceContext.mounted) {
              Navigator.pop(sourceContext);
            }
          });
        }
      },
      actionText: PersonsStrings.add,
      sourceContext: sourceContext,
    );
  }

  CustomTextFormField _personPercentage() {
    return CustomTextFormField(
      controller: valueController,
      fontWeight: FontWeight.normal,
      labelText: PersonsStrings.percentage,
      keyboardType: const TextInputType.numberWithOptions(decimal: true),
      inputFormatters: getInputFormatters(ConstantsManager.valueRegex),
      validator: (value) {
        if (value!.isEmpty) {
          return PersonsStrings.enterPercentage;
        } else if (value.isNotEmpty) {
          // Check if the person percentage is valid
          if (double.parse(value) < 0 && double.parse(value) > 100) {
            return PersonsStrings.invalidPercentage;
          }
        }
        return null;
      },
    );
  }

  CustomTextFormField _personName() {
    return CustomTextFormField(
      controller: nameController,
      fontWeight: FontWeight.normal,
      labelText: PersonsStrings.name,
      keyboardType: labelInputType,
      inputFormatters: labelInputFormatters,
      validator: (value) {
        if (value!.isEmpty) {
          return StringsManager.enterName;
        } else if (value.isNotEmpty) {
          // Check if the person name already exists
          if (personsCubit.personItems.any(
            (element) => element.name == value,
          )) {
            return PersonsStrings.personExists;
          }
        }
        return null;
      },
    );
  }
}
