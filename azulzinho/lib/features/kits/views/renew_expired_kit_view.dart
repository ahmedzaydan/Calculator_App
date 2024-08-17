import 'package:azulzinho/core/utils/constants_manager.dart';
import 'package:azulzinho/themes/strings_manager.dart';
import 'package:azulzinho/core/utils/extensions.dart';
import 'package:azulzinho/core/utils/functions.dart';
import 'package:azulzinho/core/widgets/custom_text_form_field.dart';
import 'package:azulzinho/core/widgets/item_widgets/action_view_layout.dart';
import 'package:azulzinho/core/widgets/item_widgets/date_input_field.dart';
import 'package:azulzinho/features/app_layout/app_layout_cubit/app_states.dart';
import 'package:azulzinho/features/kits/kit_cubit/kit_states.dart';
import 'package:azulzinho/features/kits/models/kit_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

import '../kit_cubit/kit_cubit.dart';

class RenewExpiredKitView extends StatelessWidget {
  RenewExpiredKitView({
    super.key,
    required this.kit,
  });

  final TextEditingController _valueController = TextEditingController();
  final TextEditingController _startDateController = TextEditingController();
  final TextEditingController _endDateController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  final KitModel kit;

  @override
  Widget build(BuildContext context) {
    _valueController.text = kit.value.toString();

    return BlocConsumer<KitsCubit, AppStates>(
      listener: (context, state) {
        if (state is RenewKitSuccessState) {
          Navigator.pop(context);
        }
      },
      builder: (context, state) {
        var cubit = KitsCubit.of(context);

        return ActionViewLayout(
          title: '${KitsStrings.renew} ${kit.name}',
          onActionPressed: () async {
            if (_formKey.currentState!.validate()) {
              cubit.renewExpiredKit(
                kitModel: kit,
                value: _valueController.text.toDouble(),
              );
            }
          },
          actionText: KitsStrings.renew,
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Kit name
                CustomTextFormField(
                  controller: TextEditingController(text: kit.name),
                  labelText: KitsStrings.kitNumber,
                  readOnly: true,
                  enabled: false,
                ),
                Gap(20.h),

                // Kit value
                CustomTextFormField(
                  controller: _valueController,
                  labelText: KitsStrings.kitValue,
                  inputFormatters:
                      getInputFormatters(ConstantsManager.valueRegex),
                  validator: (value) => cubit.validateKitValue(value),
                ),
                Gap(20.h),

                // Start date
                DateInputField(
                  controller: _startDateController,
                  label: KitsStrings.startDate,
                  onDateSelected: (date) {
                    cubit.startDate = getFormattedDate(date: date);
                  },
                  validator: (_) => cubit.validateStartDate(),
                  startFromNow: true,
                ),

                Gap(20.h),

                // End date
                DateInputField(
                  controller: _endDateController,
                  label: KitsStrings.endDate,
                  onDateSelected: (date) {
                    cubit.endDate = getFormattedDate(date: date);
                  },
                  validator: (_) => cubit.validateEndDate(),
                  startFromNow: true,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
