import 'package:calculator/app/resources/constants_manager.dart';
import 'package:calculator/app/resources/strings_manager.dart';
import 'package:calculator/app/utils/functions.dart';
import 'package:calculator/features/persons/person_cubit/persons_cubit.dart';
import 'package:calculator/features/persons/person_cubit/persons_states.dart';
import 'package:calculator/features/settings/widgets/add_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class EditPersonsListView extends StatelessWidget {
  const EditPersonsListView({super.key});

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
        return Scaffold(
          appBar: customAppBar(
            text: StringsManager.editPersons,
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // TODO: change
                  // PersonsListView(),
                  const Gap(50),
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
                  ),
                  const Gap(20),
                  // SaveButton(onPressed: () => cubit.savePersonsData()),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
