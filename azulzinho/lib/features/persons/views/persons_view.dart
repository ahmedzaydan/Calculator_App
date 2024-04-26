import 'package:azulzinho/app/resources/constants_manager.dart';
import 'package:azulzinho/app/resources/strings_manager.dart';
import 'package:azulzinho/app/resources/values_manager.dart';
import 'package:azulzinho/app/utils/functions.dart';
import 'package:azulzinho/app/widgets/add_item_widget.dart';
import 'package:azulzinho/app/widgets/custom_error_widget.dart';
import 'package:azulzinho/app/widgets/loading_widget.dart';
import 'package:azulzinho/features/app_layout/app_layout_cubit/app_states.dart';
import 'package:azulzinho/features/persons/person_cubit/persons_cubit.dart';
import 'package:azulzinho/features/persons/person_cubit/persons_states.dart';
import 'package:azulzinho/features/persons/views/add_person_view.dart';
import 'package:azulzinho/features/persons/views/widgets/admin_widget.dart';
import 'package:azulzinho/features/persons/views/widgets/persons_list_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class PersonsView extends StatelessWidget {
  const PersonsView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PersonsCubit, AppStates>(
      listener: (_, state) {
        if (state is AddPersonErrorState) {
          showCustomToast(state.message, ToastStates.error);
        }

        if (state is AddPersonSuccessState) {
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

        if (state is LoadPersonsDataErrorState) {
          showCustomToast(state.message, ToastStates.error);
        }
      },
      builder: (_, state) {
        if (state is PersonInitialState ||
            state is LoadingDataState ||
            state is LoadPersonsDataLoadingState) {
          return const LoadingWidget(message: PersonsStrings.loadingPersons);
        }

        // in case of error
        else if (state is LoadingDataErrorState) {
          return CustomErrorWidget(state.message);
        } else if (state is LoadPersonsDataErrorState) {
          return CustomErrorWidget(state.message);
        }

        return _buildPersonsViewBody(context);
      },
    );
  }

  SingleChildScrollView _buildPersonsViewBody(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppPadding.p20,
          vertical: AppPadding.p20,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // admin widget
            AdminWidget(sourceContext: context),

            const Gap(20),

            // add person inkwell
            AddItemWidget(
              text: PersonsStrings.addPerson,
              onTap: () {
                navigateTo(
                  context: context,
                  dest: AddPersonView(sourceContext: context),
                );
              },
            ),

            const Gap(60),

            PersonsListView(sourceContext: context),
          ],
        ),
      ),
    );
  }
}
