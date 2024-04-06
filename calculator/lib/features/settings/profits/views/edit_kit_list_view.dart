import 'package:calculator/app/resources/constants_manager.dart';
import 'package:calculator/app/resources/strings_manager.dart';
import 'package:calculator/app/utils/dependency_injection.dart';
import 'package:calculator/app/utils/functions.dart';
import 'package:calculator/features/settings/profits/profit_cubit/profit_cubit.dart';
import 'package:calculator/features/settings/profits/profit_cubit/profit_states.dart';
import 'package:calculator/features/settings/widgets/add_item_widget.dart';
import 'package:calculator/features/settings/widgets/profits_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class EditKitListView extends StatelessWidget {
  const EditKitListView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProfitsCubit, ProfitsStates>(
      listener: (context, state) {
        if (state is AddProfitErrorState) {
          kprint(state.message);
          showCustomToast(
            message: state.message,
            state: ToastStates.error,
          );
        }
      },
      builder: (_, __) {
        var cubit = locator<ProfitsCubit>();
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
                  ProfitsList(),
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
                  // SaveButton(
                  //   onPressed: () async {
                  //     await cubit.saveProfitData();
                  //   },
                  // ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
