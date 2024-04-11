import 'package:calculator/app/resources/color_manager.dart';
import 'package:calculator/app/resources/strings_manager.dart';
import 'package:calculator/app/resources/values_manager.dart';
import 'package:calculator/app/utils/dependency_injection.dart';
import 'package:calculator/app/widgets/custom_icon_button.dart';
import 'package:calculator/features/app_layout/app_layout_cubit/app_states.dart';
import 'package:calculator/features/calculator/calculator_cubit/calculator_cubit.dart';
import 'package:calculator/features/calculator/widgets/basic_info.dart';
import 'package:calculator/features/calculator/widgets/note.dart';
import 'package:calculator/features/calculator/widgets/results_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
            padding: const EdgeInsets.all(20.0),
            child: SingleChildScrollView(
              child: BlocBuilder<CalculatorCubit, AppStates>(
                builder: (context, state) {
                  var cubit = locator<CalculatorCubit>();
                  return Column(
                    children: [
                      const Gap(10),
                      const BasicInfo(),
                      const Gap(50),
                      const ResultsSection(),
                      const Gap(50),
                      Note(cubit: cubit),
                      const Gap(50),
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
    return AppBar(
      toolbarHeight: MediaQuery.sizeOf(context).height * 0.09,
      title: const Text(
        CalculatorStrings.reportScreen,
        style: TextStyle(
          fontSize: AppSize.s24,
          fontWeight: FontWeight.bold,
        ),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: AppPadding.p30),
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
      leading: IconButton(
        icon: const FaIcon(
          FontAwesomeIcons.arrowLeft,
          color: Colors.white,
          size: 32,
        ),
        onPressed: () => Navigator.pop(context),
      ),
    );
  }
}
