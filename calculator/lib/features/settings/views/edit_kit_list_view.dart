import 'package:calculator/app/calculator_cubit/calculator_cubit.dart';
import 'package:calculator/app/calculator_cubit/calculator_state.dart';
import 'package:calculator/app/resources/constants_manager.dart';
import 'package:calculator/app/resources/strings_manager.dart';
import 'package:calculator/app/utils/functions.dart';
import 'package:calculator/features/settings/widgets/add_item_widget.dart';
import 'package:calculator/features/settings/widgets/profits_list.dart';
import 'package:calculator/features/settings/widgets/save_button.dart';
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ProfitsList(cubit: cubit),
                  const Gap(50),
                  Text(
                    StringsManager.addKit,
                    style: getTextStyle(),
                  ),
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
