import 'package:calculator/app/resources/color_manager.dart';
import 'package:calculator/app/resources/constants_manager.dart';
import 'package:calculator/app/resources/strings_manager.dart';
import 'package:calculator/app/resources/styles_manager.dart';
import 'package:calculator/app/resources/values_manager.dart';
import 'package:calculator/app/utils/functions.dart';
import 'package:calculator/app/widgets/custom_error_widget.dart';
import 'package:calculator/app/widgets/loading_widget.dart';
import 'package:calculator/features/app_layout/app_layout_cubit/app_states.dart';
import 'package:calculator/features/kits/kit_cubit/kit_cubit.dart';
import 'package:calculator/features/kits/kit_cubit/kit_states.dart';
import 'package:calculator/features/kits/views/add_kit_view.dart';
import 'package:calculator/features/kits/views/widgets/kits_lists_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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

        if (state is LoadingKitsDataErrorState) {
          showCustomToast(state.message, ToastStates.error);
        }
      },
      builder: (_, state) {
        if (state is AppLayoutInitialState ||
            state is LoadingDataState ||
            state is KitsInitialState ||
            state is LoadKitsDataLoadingState) {
          return const LoadingWidget(message: KitsStrings.loadingKits);
        }

        // in case of error
        else if (state is LoadingDataErrorState) {
          return CustomErrorWidget(state.message);
        } else if (state is LoadingKitsDataErrorState) {
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
            // add kit inkwell
            Container(
              decoration: BoxDecoration(
                color: ColorManager.primary,
                borderRadius: BorderRadius.circular(10),
              ),
              padding: const EdgeInsets.symmetric(
                horizontal: AppPadding.p14,
              ),
              height: MediaQuery.sizeOf(context).height * 0.1,
              child: InkWell(
                highlightColor: ColorManager.transparent,
                onTap: () {
                  navigateTo(
                    context: context,
                    dest: AddKitView(sourceContext: context),
                  );
                },
                child: Row(
                  children: [
                    Text(
                      KitsStrings.addKit,
                      style: TextStylesManager.textStyle28.copyWith(
                        color: ColorManager.white,
                      ),
                    ),

                    const Spacer(),

                    // arrow
                    FaIcon(
                      FontAwesomeIcons.angleRight,
                      color: ColorManager.white,
                      size: 32,
                    ),

                    const Gap(10),
                  ],
                ),
              ),
            ),

            const Gap(20),
            KitsListsView(sourceContext: context),
          ],
        ),
      ),
    );
  }
}
