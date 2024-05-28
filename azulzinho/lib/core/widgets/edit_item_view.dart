import 'package:azulzinho/core/resources/constants_manager.dart';
import 'package:azulzinho/core/resources/strings_manager.dart';
import 'package:azulzinho/core/resources/values_manager.dart';
import 'package:azulzinho/core/utils/dependency_injection.dart';
import 'package:azulzinho/core/utils/extensions.dart';
import 'package:azulzinho/core/utils/functions.dart';
import 'package:azulzinho/core/widgets/add_or_update_cancel_widget.dart';
import 'package:azulzinho/core/widgets/custom_text_form_field.dart';
import 'package:azulzinho/features/kits/kit_cubit/kit_cubit.dart';
import 'package:azulzinho/features/kits/models/kit_model.dart';
import 'package:azulzinho/features/persons/person_cubit/persons_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class EditItemView extends StatelessWidget {
  EditItemView({
    super.key,
    required this.label,
    required this.value,
    required this.sourceContext,
    this.updateKit = false,
    // indcates that we are updating admin data
    this.index = -1,
    this.kitModel,
  });

  final String label;
  final double value;
  final int index;
  final bool updateKit;
  final BuildContext sourceContext;
  final KitModel? kitModel;

  final TextEditingController valueController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    valueController.text = value.toString();

    return Scaffold(
      appBar: customAppBar(
        context: sourceContext,
        title: updateKit
            ? 'Atualizar valor de $label'
            : 'Atualizar porcentagem de $label',
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          vertical: AppPadding.p50.h,
          horizontal: AppPadding.p20.w,
        ),
        child: Form(
          key: formKey,
          child: Column(
            children: [
              // value input
              CustomTextFormField(
                controller: valueController,
                labelText: label,
                fontWeight: FontWeight.bold,
                validator: (value) {
                  if (value!.isEmpty) {
                    return updateKit
                        ? KitsStrings.enterValue
                        : PersonsStrings.enterPercentage;
                  }
                  else if (value.isNotEmpty) {
                    if (label == PersonsStrings.admin) {
                      if (double.parse(value) < 0 ||
                          double.parse(value) > 100) {
                        return PersonsStrings.invalidPercentage;
                      }
                    }
                  }
                  return null;
                },
                inputFormatters:
                    getInputFormatters(ConstantsManager.valueRegex),
              ),

              Gap(30.h),

              _actions(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _actions() {
    return AddUpdateCancelWidget(
      onPressed: () async {
        var kitsCubit = locator<KitsCubit>();
        if (formKey.currentState!.validate()) {
          if (updateKit) {
            kitsCubit
                .updateKit(
              kitModel: kitModel!,
              value: valueController.text.toDouble(),
            )
                .then((response) {
              if (response == true && sourceContext.mounted) {
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
                  if (response == true && sourceContext.mounted) {
                    Navigator.pop(sourceContext);
                  }
                },
              );
            } else {
              locator<PersonsCubit>()
                  .updatePerson(
                index: index,
                value: double.parse(valueController.text),
              )
                  .then(
                (response) {
                  if ((response == true) && sourceContext.mounted) {
                    Navigator.pop(sourceContext);
                  }
                },
              );
            }
          }
        }
      },
      actionText: StringsManager.update,
      sourceContext: sourceContext,
    );
  }
}
