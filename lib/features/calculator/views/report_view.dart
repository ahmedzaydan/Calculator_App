import 'package:azulzinho/themes/strings_manager.dart';
import 'package:azulzinho/core/utils/dependency_injection.dart';
import 'package:azulzinho/core/widgets/custom_app_bar.dart';
import 'package:azulzinho/core/widgets/custom_icon_button.dart';
import 'package:azulzinho/features/app_layout/app_layout_cubit/app_states.dart';
import 'package:azulzinho/features/calculator/calculator_cubit/calculator_cubit.dart';
import 'package:azulzinho/features/calculator/widgets/report/basic_info.dart';
import 'package:azulzinho/features/calculator/widgets/report/logo_widget.dart';
import 'package:azulzinho/features/calculator/widgets/report/note.dart';
import 'package:azulzinho/features/calculator/widgets/report/results_section.dart';
import 'package:azulzinho/themes/color_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:screenshot/screenshot.dart';

class ReportView extends StatelessWidget {
  ReportView({super.key});

  @override
  Widget build(BuildContext context) {
    var calculatorCubit = locator<CalculatorCubit>();

    return SafeArea(
      child: Scaffold(
        appBar: CustomAppBar(
          title: CalculatorStrings.reportScreen,
          actions: [
            Padding(
              padding: EdgeInsets.only(
                right: 24.w,
              ),
              child: CustomIconButton(
                onPressed: () => calculatorCubit.captureAndShare(),
                faIcon: FaIcon(
                  FontAwesomeIcons.solidShareFromSquare,
                  color: ColorManager.white,
                  size: 24.sp,
                ),
              ),
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: BlocBuilder<CalculatorCubit, AppStates>(
            builder: (context, state) {
              var cubit = locator<CalculatorCubit>();
              return Screenshot(
                controller: cubit.screenshotController,
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 20.w,
                    vertical: 20.h,
                  ),
                  color: ColorManager.white,
                  child: Column(
                    children: [
                      const BasicInfo(),
                      LogoWidget(),
                      const ResultsSection(),
                      Note(note: cubit.note),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
