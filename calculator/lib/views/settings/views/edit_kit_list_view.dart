import 'package:calculator/core/calculator_cubit/calculator_cubit.dart';
import 'package:calculator/core/calculator_cubit/calculator_state.dart';
import 'package:calculator/core/models/profit_model.dart';
import 'package:calculator/core/resources/constants_manager.dart';
import 'package:calculator/core/resources/strings_manager.dart';
import 'package:calculator/core/utils/functions.dart';
import 'package:calculator/core/widgets/custom_list_view.dart';
import 'package:calculator/views/settings/widgets/add_item_widget.dart';
import 'package:calculator/views/settings/widgets/edit_item_widget.dart';
import 'package:calculator/views/settings/widgets/save_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class EditKitListView extends StatelessWidget {
  const EditKitListView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CalculatorCubit, CalculatorState>(
      listener: (context, state) {
        if (state is AddProfitFailedState) {
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
            text: StringsManager.editKitList,
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
                  ProfitsList(cubit: cubit),
                  const Gap(20),
                  AddItemWidget(
                    name: StringsManager.profitNumber,
                    nameValidator: StringsManager.enterNumber,
                    value: StringsManager.profitValue,
                    valueValidator: StringsManager.enterValue,
                    inputType: TextInputType.number,
                  ),
                  const Gap(20),
                  SaveButton(
                    onPressed: () async {
                      await cubit.saveProfitData();
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class ProfitsList extends StatelessWidget {
  const ProfitsList({
    super.key,
    required this.cubit,
  });

  final CalculatorCubit cubit;

  @override
  Widget build(BuildContext context) {
    return CustomListView(
      itemBuilder: (context, index) {
        ProfitModel profit = cubit.profitItems[index];
        return EditItemWidget(
          value: profit.value,
          name: profit.id,
          onChanged: (value) async {
            await cubit.editProfitValue(
              index: index,
              value: value,
            );
          },
          deleteOnPressed: () async => await cubit.deleteProfitItem(index),
        );
      },
      itemCount: cubit.profitItems.length,
    );
  }
}
