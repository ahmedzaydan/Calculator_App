import 'package:calculator/app/resources/constants_manager.dart';
import 'package:calculator/app/resources/strings_manager.dart';
import 'package:calculator/app/resources/values_manager.dart';
import 'package:calculator/app/utils/functions.dart';
import 'package:calculator/features/app_layout/app_layout_cubit/app_states.dart';
import 'package:calculator/features/kits/kit_cubit/kit_cubit.dart';
import 'package:calculator/features/kits/kit_cubit/kit_states.dart';
import 'package:calculator/features/kits/views/widgets/kits_list_view.dart';
import 'package:calculator/features/widgets/add_item_widget.dart';
import 'package:calculator/features/widgets/custom_error_widget.dart';
import 'package:calculator/features/widgets/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class KitsView extends StatelessWidget {
  const KitsView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<KitsCubit, AppStates>(
      listener: (_, state) {
        if (state is AddKitErrorState) {
          kprint(state.message);
          showCustomToast(
            message: state.message,
            state: ToastStates.error,
          );
        }
      },
      builder: (_, state) {
        if (state is LoadingDataState) {
          return const LoadingWidget();
        } else if (state is LoadingDataErrorState) {
          return CustomErrorWidget(state.message);
        }
        return _buildKitsView(context);
      },
    );
  }

  Widget _buildKitsView(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppPadding.p10),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // add kit widget
            Text(
              StringsManager.addKit,
              style: getTextStyle(),
            ),

            const Gap(20),

            AddItemWidget(
              name: StringsManager.kitNumber,
              nameValidator: StringsManager.enterNumber,
              value: StringsManager.kitValue,
              valueValidator: StringsManager.enterValue,
              inputType: const TextInputType.numberWithOptions(
                decimal: false,
              ),
              inputFormatters: getInputFormatters(ConstantsManager.kitsRegex),
              isPerson: false,
            ),

            const Gap(40),

            KitsListView(sourceContext: context),
          ],
        ),
      ),
    );
  }
}
