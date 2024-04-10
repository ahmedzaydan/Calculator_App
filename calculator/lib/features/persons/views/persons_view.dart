import 'package:calculator/app/resources/constants_manager.dart';
import 'package:calculator/app/resources/values_manager.dart';
import 'package:calculator/app/utils/functions.dart';
import 'package:calculator/app/widgets/add_item_widget.dart';
import 'package:calculator/app/widgets/custom_error_widget.dart';
import 'package:calculator/app/widgets/loading_widget.dart';
import 'package:calculator/features/app_layout/app_layout_cubit/app_states.dart';
import 'package:calculator/features/persons/person_cubit/persons_cubit.dart';
import 'package:calculator/features/persons/person_cubit/persons_states.dart';
import 'package:calculator/features/persons/views/widgets/admin_widget.dart';
import 'package:calculator/features/persons/views/widgets/persons_list_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
        if (state is LoadingDataState) {
          return const LoadingWidget();
        } else if (state is LoadingDataErrorState) {
          return CustomErrorWidget(state.message);
        }
        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppPadding.p14,
              vertical: AppPadding.p20,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // admin widget
                Container(
                  margin: const EdgeInsets.only(top: AppMargin.m20),
                  child: AdminWidget(sourceContext: context),
                ),

                Padding(
                  padding: const EdgeInsets.only(
                    top: AppPadding.p24,
                    bottom: AppPadding.p40,
                  ),
                  child: AddItemWidget(
                    isPerson: true,
                    labelInputType: TextInputType.text,
                  ),
                ),

                PersonsListView(sourceContext: context),
              ],
            ),
          ),
        );
      },
    );
  }
}
