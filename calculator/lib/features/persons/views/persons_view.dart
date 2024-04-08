import 'package:calculator/app/resources/constants_manager.dart';
import 'package:calculator/app/resources/values_manager.dart';
import 'package:calculator/app/utils/functions.dart';
import 'package:calculator/features/app_layout/app_layout_cubit/app_states.dart';
import 'package:calculator/features/persons/person_cubit/persons_cubit.dart';
import 'package:calculator/features/persons/person_cubit/persons_states.dart';
import 'package:calculator/features/persons/views/widgets/admin_widget.dart';
import 'package:calculator/features/persons/views/widgets/persons_list_view.dart';
import 'package:calculator/features/widgets/add_item_widget.dart';
import 'package:calculator/features/widgets/custom_error_widget.dart';
import 'package:calculator/features/widgets/loading_widget.dart';
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
        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // admin widget
              Container(
                margin: const EdgeInsets.symmetric(vertical: AppMargin.m10),
                child: AdminWidget(sourceContext: context),
              ),

              // add item widget
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppPadding.p10),
                child: AddItemWidget(
                  isPerson: true,
                  labelInputType: TextInputType.text,
                ),
              ),

              const Gap(20),

              // persons list view
              PersonsListView(sourceContext: context),
            ],
          ),
        );
      },
    );
  }
}
