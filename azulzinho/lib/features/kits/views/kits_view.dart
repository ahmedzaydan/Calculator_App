import 'package:azulzinho/app/resources/constants_manager.dart';
import 'package:azulzinho/app/resources/strings_manager.dart';
import 'package:azulzinho/app/utils/functions.dart';
import 'package:azulzinho/app/widgets/custom_error_widget.dart';
import 'package:azulzinho/app/widgets/loading_widget.dart';
import 'package:azulzinho/features/app_layout/app_layout_cubit/app_states.dart';
import 'package:azulzinho/features/kits/kit_cubit/kit_cubit.dart';
import 'package:azulzinho/features/kits/kit_cubit/kit_states.dart';
import 'package:azulzinho/features/kits/views/widgets/kits_view_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class KitsView extends StatelessWidget {
  const KitsView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<KitsCubit, AppStates>(
      listener: (_, state) {
        if (state is CreateKitErrorState) {
          showCustomToast(state.message, ToastStates.error);
        }

        if (state is CreateKitSuccessState) {
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

        if (state is FetchKitsErrorState) {
          showCustomToast(state.message, ToastStates.error);
        }
      },
      builder: (_, state) {
        if (state is AppLayoutInitialState ||
            state is LoadingDataState ||
            state is KitsInitialState ||
            state is FetchKitsDataLoadingState) {
          return const LoadingWidget(message: KitsStrings.loadingKits);
        }

        // in case of error
        else if (state is LoadingDataErrorState) {
          return CustomErrorWidget(state.message);
        } else if (state is FetchKitsErrorState) {
          return CustomErrorWidget(state.message);
        }

        return KitsViewBody();
      },
    );
  }
}
