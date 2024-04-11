import 'package:calculator/app/resources/constants_manager.dart';
import 'package:calculator/app/resources/strings_manager.dart';
import 'package:calculator/app/resources/values_manager.dart';
import 'package:calculator/app/utils/functions.dart';
import 'package:calculator/app/widgets/add_item_widget.dart';
import 'package:calculator/app/widgets/custom_error_widget.dart';
import 'package:calculator/app/widgets/loading_widget.dart';
import 'package:calculator/features/app_layout/app_layout_cubit/app_states.dart';
import 'package:calculator/features/kits/kit_cubit/kit_cubit.dart';
import 'package:calculator/features/kits/kit_cubit/kit_states.dart';
import 'package:calculator/features/kits/views/widgets/kits_lists_view.dart';
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
          showCustomToast(state.message, ToastStates.error);
        }

        if (state is AddKitSuccessState) {
          showCustomToast(state.message, ToastStates.success);
        }

        if (state is UpdateKitErrorState) {
          kprint(state.message);
          showCustomToast(state.message, ToastStates.error);
        }

        if (state is UpdateKitSuccessState) {
          showCustomToast(state.message, ToastStates.success);
        }

        if (state is DeleteKitErrorState) {
          showCustomToast(state.message, ToastStates.error);
        }

        if (state is DeleteKitSuccessState) {
          showCustomToast(state.message, ToastStates.success);
        }

        if (state is LoadKitsDataErrorState) {
          showCustomToast(state.message, ToastStates.error);
        }
      },
      builder: (_, state) {
        if (state is LoadingDataState || state is LoadKitsDataLoadingState) {
          return const LoadingWidget(
            message: KitsStrings.loadingKits,
          );
        } else if (state is LoadingDataErrorState) {
          return CustomErrorWidget(state.message);
        }
        return _buildKitsView(context);
      },
    );
  }

  Widget _buildKitsView(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppPadding.p14,
          vertical: AppPadding.p24,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AddItemWidget(
              labelInputType:
                  const TextInputType.numberWithOptions(decimal: false),
              labelInputFormatters:
                  getInputFormatters(ConstantsManager.kitsRegex),
            ),
            const Gap(40),
            KitsListsView(sourceContext: context),
          ],
        ),
      ),
    );
  }
}
