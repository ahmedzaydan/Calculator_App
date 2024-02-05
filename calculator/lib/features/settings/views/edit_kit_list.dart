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

class EditKitList extends StatelessWidget {
  const EditKitList({super.key});

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
      builder: (_, state) {
        return Scaffold(
          appBar: customAppBar(text: StringsManager.editKitList),
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: SingleChildScrollView(
              child: BlocBuilder<CalculatorCubit, CalculatorState>(
                builder: (context, state) {
                  var cubit = CalculatorCubit.get(context);
                  return Column(
                    children: [
                      ProfitsList(cubit: cubit),
                      const Gap(20),
                      AddItemWidget(
                        name: StringsManager.profitNumber,
                        nameValidator: StringsManager.enterNumber,
                        value: StringsManager.profitValue,
                        valueValidator: StringsManager.enterValue,
                      ),
                      const Gap(20),
                      SaveButton(onPressed: () => cubit.saveProfitData()),
                    ],
                  );
                },
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
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        String key = cubit.profitKeys[index];
        return EditItemWidget(
          value: cubit.profits[key].toString(),
          name: key,
          onChanged: (value) => cubit.profits[key] = double.parse(value),
          deleteOnPressed: () async {
            await cubit.deleteProfitItem(profitId: key);
          },
        );
      },
      separatorBuilder: (context, index) => const Gap(10),
      itemCount: cubit.profitKeys.length,
    );
  }
}
