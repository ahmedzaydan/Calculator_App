import 'package:calculator/app/calculator_cubit/calculator_cubit.dart';
import 'package:calculator/app/calculator_cubit/calculator_state.dart';
import 'package:calculator/app/resources/constants_manager.dart';
import 'package:calculator/app/resources/strings_manager.dart';
import 'package:calculator/app/utils/functions.dart';
import 'package:calculator/features/settings/widgets/add_item_widget.dart';
import 'package:calculator/features/settings/widgets/save_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

import '../widgets/persons_list.dart';

class EditPersonsListView extends StatelessWidget {
  const EditPersonsListView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CalculatorCubit, CalculatorState>(
      listener: (context, state) {
        if (state is AddPersonErrorState) {
          showCustomToast(
            message: state.message,
            state: ToastStates.error,
          );
        }
      },
      builder: (context2, state) {
        var cubit = CalculatorCubit.get(context2);
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
                  PersonsList(cubit: cubit),
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
                  SaveButton(onPressed: () => cubit.savePersonsData()),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
