import 'package:azulzinho/core/resources/constants_manager.dart';
import 'package:azulzinho/core/resources/strings_manager.dart';
import 'package:azulzinho/core/utils/functions.dart';
import 'package:azulzinho/core/widgets/custom_error_widget.dart';
import 'package:azulzinho/core/widgets/loading_widget.dart';
import 'package:azulzinho/features/app_layout/app_layout_cubit/app_states.dart';
import 'package:azulzinho/features/persons/person_cubit/persons_cubit.dart';
import 'package:azulzinho/features/persons/person_cubit/persons_states.dart';
import 'package:azulzinho/features/persons/views/widgets/persons_view_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PersonsView extends StatelessWidget {
  const PersonsView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PersonsCubit, AppStates>(
      listener: (_, state) {
        if (state is CreatePersonErrorState) {
          showCustomToast(state.message, ToastStates.error);
        }

        if (state is CreatePersonSuccessState) {
          showCustomToast(state.message, ToastStates.success);
        }

        if (state is UpdatePersonErrorState) {
          showCustomToast(state.message, ToastStates.error);
        }

        if (state is UpdatePersonSuccessState) {
          showCustomToast(state.message, ToastStates.success);
        }

        if (state is DeletePersonErrorState) {
          showCustomToast(state.message, ToastStates.error);
        }

        if (state is DeletePersonSuccessState) {
          showCustomToast(state.message, ToastStates.success);
        }

        if (state is FetchPersonsErrorState) {
          showCustomToast(state.message, ToastStates.error);
        }
      },
      builder: (_, state) {
        if (state is PersonInitialState ||
            state is LoadingDataState ||
            state is FetchPersonsLoadingState) {
          return const LoadingWidget(
            message: PersonsStrings.loadingPersons,
          );
        }

        // in case of error
        else if (state is LoadingDataErrorState) {
          return CustomErrorWidget(state.message);
        } else if (state is FetchPersonsErrorState) {
          return CustomErrorWidget(state.message);
        }

        return PersonsViewBody();
      },
    );
  }
}
