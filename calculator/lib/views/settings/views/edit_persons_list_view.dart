import 'package:calculator/core/calculator_cubit/calculator_cubit.dart';
import 'package:calculator/core/calculator_cubit/calculator_state.dart';
import 'package:calculator/core/utils/functions.dart';
import 'package:calculator/core/models/person_model.dart';
import 'package:calculator/core/resources/constants_manager.dart';
import 'package:calculator/core/resources/strings_manager.dart';
import 'package:calculator/core/widgets/custom_list_view.dart';
import 'package:calculator/views/settings/widgets/add_item_widget.dart';
import 'package:calculator/views/settings/widgets/edit_item_widget.dart';
import 'package:calculator/views/settings/widgets/save_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

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
              cubit.sortProfits();
              Navigator.pop(context);
            },
          ),
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  PersonsList(cubit: cubit),
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

class PersonsList extends StatelessWidget {
  const PersonsList({
    super.key,
    required this.cubit,
  });

  final CalculatorCubit cubit;

  @override
  Widget build(BuildContext context) {
    return CustomListView(
      itemBuilder: (context, index) {
        PersonModel person = cubit.personItems[index];
        return EditItemWidget(
          value: person.netProfitValue,
          name: person.name,
          onChanged: (value) {
            cubit.editPersonPercentage(
              index: index,
              value: value,
            );
          },
          deleteOnPressed: () async => await cubit.deletePerson(index),
        );
      },
      itemCount: cubit.personItems.length,
    );
  }
}
