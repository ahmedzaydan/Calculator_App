import 'package:azulzinho/core/resources/constants_manager.dart';
import 'package:azulzinho/core/resources/strings_manager.dart';
import 'package:azulzinho/core/utils/extensions.dart';
import 'package:azulzinho/core/utils/functions.dart';
import 'package:azulzinho/core/widgets/add_or_update_cancel_widget.dart';
import 'package:azulzinho/core/widgets/custom_text_form_field.dart';
import 'package:azulzinho/core/widgets/item_widgets/add_item_view_layout.dart';
import 'package:azulzinho/core/widgets/item_widgets/date_input_field.dart';
import 'package:azulzinho/features/app_layout/app_layout_cubit/app_states.dart';
import 'package:azulzinho/features/kits/kit_cubit/kit_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

import '../../../core/utils/dependency_injection.dart';
import '../kit_cubit/kit_cubit.dart';

// TODO:
// 1- add end date
// 2- make them widgets not functions
class AddKitView extends StatelessWidget {
  AddKitView({
    super.key,
    required this.sourceContext,
  });

  final BuildContext sourceContext;

  final TextEditingController _kitNameController = TextEditingController();
  final TextEditingController _kitValueController = TextEditingController();
  final TextEditingController _startDateController = TextEditingController();
  final TextEditingController _endDateController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var cubit = KitsCubit.of(context);

    return BlocConsumer<KitsCubit, AppStates>(
      listener: (context, state) {
        if (state is CreateKitSuccessState) {
          Navigator.pop(context);
        }
      },
      builder: (context, state) {
        return AddItemViewLayout(
          title: KitsStrings.addKit,
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Kit name
                CustomTextFormField(
                  controller: _kitNameController,
                  labelText: KitsStrings.kitNumber,
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: false),
                  inputFormatters:
                      getInputFormatters(ConstantsManager.kitsRegex),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return KitsStrings.enterNumber;
                    } else if (value.isNotEmpty) {
                      // Check if the kit number already exists
                      if (locator<KitsCubit>()
                          .kits
                          .any((element) => element.name == value)) {
                        return KitsStrings.kitExists;
                      }
                    }
                    return null;
                  },
                ),
                Gap(20.h),

                // Kit value
                CustomTextFormField(
                  controller: _kitValueController,
                  labelText: KitsStrings.kitValue,
                  inputFormatters:
                      getInputFormatters(ConstantsManager.valueRegex),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return KitsStrings.enterValue;
                    }
                    return null;
                  },
                ),
                Gap(20.h),

                // Start date
                DateInputField(
                  controller: _startDateController,
                  label: KitsStrings.startDate,
                  onDateSelected: (date) {
                    cubit.startDate = getFormattedDate(date: date);
                  },
                  validator: (date) {
                    if (cubit.startDate == null) {
                      return KitsStrings.enterStartDate;
                    }

                    return null;
                  },
                ),

                Gap(20.h),

                // End date
                DateInputField(
                  controller: _endDateController,
                  label: KitsStrings.endDate,
                  onDateSelected: (date) {
                    cubit.endDate = getFormattedDate(date: date);
                    kprint("end date controller ${_endDateController.text}");
                  },
                  validator: (date) {
                    // If end date is before start date
                    if (cubit.endDate != null &&
                        cubit.endDate!.isBefore(cubit.startDate!)) {
                      return KitsStrings.endDateBeforeStartDate;
                    }
                    return null;
                  },
                ),
                Gap(20.h),

                // add or cancel buttons
                ItemActionButtons(
                  onActionPressed: () async {
                    var kitsCubit = locator<KitsCubit>();
                    if (_formKey.currentState!.validate()) {
                      kitsCubit.createKit(
                        name: _kitNameController.text,
                        value: _kitValueController.text.toDouble(),
                      );
                    }
                  },
                  actionText: KitsStrings.add,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
