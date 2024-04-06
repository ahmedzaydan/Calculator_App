import 'package:calculator/app/resources/strings_manager.dart';
import 'package:calculator/features/home/calculator_cubit/calculator_cubit.dart';
import 'package:calculator/features/home/calculator_cubit/calculator_state.dart';
import 'package:calculator/features/output/widgets/basic_info.dart';
import 'package:calculator/features/output/widgets/note.dart';
import 'package:calculator/features/output/widgets/results_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class OutputView extends StatelessWidget {
  const OutputView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: outputAppBar(),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: BlocBuilder<CalculatorCubit, CalculatorStates>(
            builder: (context, state) {
              var cubit = CalculatorCubit.get(context);
              return Column(
                children: [
                  const BasicInfo(),
                  const Gap(50),
                  const ResultsSection(),
                  const Gap(50),
                  Note(cubit: cubit),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

AppBar outputAppBar() {
  return AppBar(
    title: const Text(
      StringsManager.outputScreen,
      style: TextStyle(
        fontWeight: FontWeight.bold,
      ),
    ),
  );
}
