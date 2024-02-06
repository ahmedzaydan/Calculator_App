import 'package:calculator/core/calculator_cubit/calculator_cubit.dart';
import 'package:calculator/core/calculator_cubit/calculator_state.dart';
import 'package:calculator/core/functions.dart';
import 'package:calculator/core/resources/constants_manager.dart';
import 'package:calculator/core/resources/strings_manager.dart';
import 'package:calculator/features/settings/views/widgets/add_item_widget.dart';
import 'package:calculator/features/settings/views/widgets/edit_item_widget.dart';
import 'package:calculator/features/settings/views/widgets/save_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class EditPersonsList extends StatelessWidget {
  const EditPersonsList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CalculatorCubit, CalculatorState>(
      listener: (context, state) {
        if (state is AddPersonFieldState) {
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
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        String key = cubit.personKeys[index];
        return EditItemWidget(
          value: cubit.persons[key].toString(),
          name: key,
          onChanged: (value) => cubit.persons[key] = double.parse(value),
          deleteOnPressed: () async {
            await cubit.deletePerson(
              name: key,
              index: index,
            );
          },
        );
      },
      separatorBuilder: (context, index) => const Gap(10),
      itemCount: cubit.personKeys.length,
    );
  }
}
