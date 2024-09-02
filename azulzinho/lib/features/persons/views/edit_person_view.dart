import 'package:azulzinho/core/utils/constants_manager.dart';
import 'package:azulzinho/themes/strings_manager.dart';
import 'package:azulzinho/core/utils/functions.dart';
import 'package:azulzinho/core/widgets/custom_text_form_field.dart';
import 'package:azulzinho/core/widgets/item_widgets/action_view_layout.dart';
import 'package:azulzinho/features/app_layout/app_layout_cubit/app_states.dart';
import 'package:azulzinho/features/persons/models/person_model.dart';
import 'package:azulzinho/features/persons/cubit/persons_cubit.dart';
import 'package:azulzinho/features/persons/cubit/persons_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EditPersonView extends StatelessWidget {
  EditPersonView({
    super.key,
    required this.person,
    this.index = -1,
  });

  final TextEditingController valueController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  final PersonModel person;
  final int index;

  @override
  Widget build(BuildContext context) {
    valueController.text = person.percentage.toString();

    return BlocConsumer<PersonsCubit, AppStates>(
      listener: (context, state) {
        if (state is UpdatePersonSuccessState) {
          Navigator.pop(context);
        }
      },
      builder: (context, state) {
        var cubit = PersonsCubit.of(context);

        return ActionViewLayout(
          title: 'Atualizar porcentagem de ${person.name}',
          onActionPressed: () {
            if (formKey.currentState!.validate()) {
              if (index == -1) {
                // update admin data
                cubit.updateAdminPercentage(
                  double.parse(valueController.text),
                );
              }

              // update person data
              else {
                cubit.updatePerson(
                  index: index,
                  value: double.parse(valueController.text),
                );
              }
            }
          },
          actionText: StringsManager.update,
          child: Form(
            key: formKey,
            child: Column(
              children: [
                // value input
                CustomTextFormField(
                  controller: valueController,
                  labelText: person.name,
                  fontWeight: FontWeight.bold,
                  validator: (value) {
                    return cubit.validatePersonPercentage(value);
                  },
                  inputFormatters:
                      getInputFormatters(ConstantsManager.valueRegex),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
