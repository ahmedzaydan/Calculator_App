import 'package:azulzinho/themes/color_manager.dart';
import 'package:azulzinho/core/resources/strings_manager.dart';
import 'package:azulzinho/core/resources/values_manager.dart';
import 'package:azulzinho/core/utils/dependency_injection.dart';
import 'package:azulzinho/core/utils/functions.dart';
import 'package:azulzinho/core/widgets/custom_icon_button.dart';
import 'package:azulzinho/features/app_layout/app_layout_cubit/app_states.dart';
import 'package:azulzinho/features/calculator/calculator_cubit/calculator_cubit.dart';
import 'package:azulzinho/features/calculator/widgets/basic_info.dart';
import 'package:azulzinho/features/calculator/widgets/note.dart';
import 'package:azulzinho/features/calculator/widgets/results_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';
import 'package:screenshot/screenshot.dart';

class ReportView extends StatelessWidget {
  ReportView({super.key});

  final ScreenshotController screenshotController = ScreenshotController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: _appBar(context),
        body: Screenshot(
          controller: screenshotController,
          child: Container(
            color: ColorManager.white,
            padding: EdgeInsets.symmetric(
              horizontal: AppPadding.p20.w,
              vertical: AppPadding.p20.h,
            ),
            child: SingleChildScrollView(
              child: BlocBuilder<CalculatorCubit, AppStates>(
                builder: (context, state) {
                  var cubit = locator<CalculatorCubit>();
                  return Column(
                    children: [
                      Gap(10.h),
                      const BasicInfo(),
                      Gap(50.h),
                      const ResultsSection(),
                      Gap(50.h),
                      Note(cubit: cubit),
                      Gap(50.h),
                    ],
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }

  AppBar _appBar(BuildContext context) {
    return customAppBar(
      context: context,
      title: CalculatorStrings.reportScreen,
      actions: [
        Padding(
          padding: EdgeInsets.only(right: AppPadding.p30.w),
          child: CustomIconButton(
            onPressed: () => locator<CalculatorCubit>()
                .captureAndShare(screenshotController),
            icon: FaIcon(
              FontAwesomeIcons.solidShareFromSquare,
              color: ColorManager.white,
              size: AppSize.s32,
            ),
          ),
        )
      ],
    );
  }
}
