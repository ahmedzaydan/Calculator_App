import 'package:calculator/app/resources/constants_manager.dart';
import 'package:calculator/app/resources/strings_manager.dart';
import 'package:calculator/app/resources/values_manager.dart';
import 'package:calculator/app/utils/functions.dart';
import 'package:calculator/features/persons/person_cubit/persons_cubit.dart';
import 'package:calculator/features/persons/person_cubit/persons_states.dart';
import 'package:calculator/features/persons/views/widgets/persons_list_view.dart';
import 'package:calculator/features/widgets/add_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class PersonsView extends StatelessWidget {
  const PersonsView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PersonsCubit, PersonsStates>(
      listener: (context, state) {
        if (state is AddPersonErrorState) {
          showCustomToast(
            message: state.message,
            state: ToastStates.error,
          );
        }
      },
      builder: (_, __) {
        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(AppPadding.p10),
                // add person widget
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      StringsManager.addPerson,
                      style: getTextStyle(),
                    ),
                    const Gap(20),
                    AddItemWidget(
                      name: StringsManager.name,
                      nameValidator: StringsManager.enterName,
                      value: StringsManager.percentage,
                      valueValidator: StringsManager.enterPercentage,
                      isPerson: true,
                      inputType: TextInputType.text,
                    ),
                  ],
                ),
              ),
              const Gap(10),
              PersonsListView(sourceContext: context),
            ],
          ),
        );
      },
    );
  }
}
