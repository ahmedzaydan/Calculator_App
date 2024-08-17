import 'package:azulzinho/core/resources/constants_manager.dart';
import 'package:azulzinho/core/resources/strings_manager.dart';
import 'package:azulzinho/core/utils/functions.dart';
import 'package:azulzinho/core/widgets/custom_text_form_field.dart';
import 'package:azulzinho/core/widgets/item_widgets/action_view_layout.dart';
import 'package:azulzinho/features/app_layout/app_layout_cubit/app_states.dart';
import 'package:azulzinho/features/persons/person_cubit/persons_cubit.dart';
import 'package:azulzinho/features/persons/person_cubit/persons_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class AddPersonView extends StatelessWidget {
  AddPersonView({
    super.key,
  });

  // controllers
  final TextEditingController nameController = TextEditingController();
  final TextEditingController valueController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PersonsCubit, AppStates>(
      listener: (context, state) {
        if (state is CreatePersonSuccessState) {
          Navigator.pop(context);
        }
      },
      builder: (context, state) {
        var cubit = PersonsCubit.of(context);

        return ActionViewLayout(
          title: PersonsStrings.addPerson,
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Name
                CustomTextFormField(
                  controller: nameController,
                  labelText: PersonsStrings.name,
                  validator: (value) => cubit.validatePresonName(value),
                ),
                Gap(20.h),

                // Value
                CustomTextFormField(
                  controller: valueController,
                  labelText: PersonsStrings.percentage,
                  inputFormatters: getInputFormatters(
                    ConstantsManager.valueRegex,
                  ),
                  validator: (value) => cubit.validatePersonPercentage(value),
                ),
              ],
            ),
          ),
          onActionPressed: () async {
            if (_formKey.currentState!.validate()) {
              cubit.createPerson(
                name: nameController.text,
                percentage: double.parse(valueController.text),
              );
            }
          },
          actionText: PersonsStrings.add,
        );
      },
    );
  }
}
