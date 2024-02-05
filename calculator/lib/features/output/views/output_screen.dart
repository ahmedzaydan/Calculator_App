import 'package:calculator/core/cubit/calculator_cubit.dart';
import 'package:calculator/core/cubit/calculator_state.dart';
import 'package:calculator/core/functions.dart';
import 'package:calculator/core/resources/strings_manager.dart';
import 'package:calculator/features/output/views/widgets/basic_info.dart';
import 'package:calculator/features/output/views/widgets/results_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class OutputScreen extends StatelessWidget {
  const OutputScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          StringsManager.outputScreen,
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/logo.jpg'),
            fit: BoxFit.cover,
            opacity: 0.15,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            child: BlocBuilder<CalculatorCubit, CalculatorState>(
              builder: (context, state) {
                var cubit = CalculatorCubit.get(context);
                return Column(
                  children: [
                    const BasicInfo(),
                    const Gap(50),
                    const ResultsSection(),
                    const Gap(50),

                    // note
                    if (cubit.note.isNotEmpty) ...[
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          StringsManager.note,
                          style: getTextStyle(),
                        ),
                      ),
                      const Gap(10),
                      Container(
                        padding: const EdgeInsets.all(10),
                        width: double.infinity,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.grey,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Directionality(
                          textDirection: getTextDirection(cubit.note),
                          child: Text(
                            cubit.note,
                            style: getTextStyle().copyWith(),
                          ),
                        ),
                      ),
                    ],
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
