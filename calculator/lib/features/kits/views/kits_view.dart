import 'package:calculator/app/resources/constants_manager.dart';
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

        if (state is AddKitSuccessState) {
          showCustomToast(
            message: state.message,
            state: ToastStates.success,
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
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppPadding.p10,
              vertical: AppPadding.p24,
            ),
            child: AddItemWidget(
              labelInputType:
                  const TextInputType.numberWithOptions(decimal: false),
              labelInputFormatters:
                  getInputFormatters(ConstantsManager.kitsRegex),
            ),
          ),
          KitsListView(sourceContext: context),
        ],
      ),
    );
  }
}
