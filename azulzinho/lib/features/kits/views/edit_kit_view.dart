import 'package:azulzinho/core/utils/constants_manager.dart';
import 'package:azulzinho/themes/strings_manager.dart';
import 'package:azulzinho/core/utils/extensions.dart';
import 'package:azulzinho/core/utils/functions.dart';
import 'package:azulzinho/core/widgets/custom_text_form_field.dart';
import 'package:azulzinho/core/widgets/item_widgets/action_view_layout.dart';
import 'package:azulzinho/features/app_layout/app_layout_cubit/app_states.dart';
import 'package:azulzinho/features/kits/kit_cubit/kit_cubit.dart';
import 'package:azulzinho/features/kits/kit_cubit/kit_states.dart';
import 'package:azulzinho/features/kits/models/kit_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EditKitView extends StatelessWidget {
  EditKitView({
    super.key,
    required this.kit,
  });

  final TextEditingController valueController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  final KitModel kit;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<KitsCubit, AppStates>(
      listener: (context, state) {
        if (state is UpdateKitSuccessState) {
          Navigator.pop(context);
        }
      },
      builder: (context, state) {
        var cubit = KitsCubit.of(context);

        valueController.text = kit.value.toString();

        return ActionViewLayout(
          title: 'Atualizar valor de ${kit.name}',
          onActionPressed: () {
            cubit.updateKit(
              kitModel: kit,
              value: valueController.text.toDouble(),
            );
          },
          actionText: StringsManager.update,
          child: Form(
            key: formKey,
            child: Column(
              children: [
                // value input
                CustomTextFormField(
                  controller: valueController,
                  labelText: kit.name,
                  fontWeight: FontWeight.bold,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return KitsStrings.enterValue;
                    }

                    return null;
                  },
                  inputFormatters: getInputFormatters(
                    ConstantsManager.valueRegex,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
