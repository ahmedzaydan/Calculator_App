import 'package:calculator/cubit/calculator_cubit.dart';
import 'package:calculator/cubit/calculator_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class OutputScreen extends StatelessWidget {
  const OutputScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Output'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: BlocBuilder<CalculatorCubit, CalculatorState>(
            builder: (context, state) {
              var cubit = CalculatorCubit.get(context);
              return Column(
                children: [
                  // total profit
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Total profit'),
                      Text(
                        '${cubit.totalProfit}',
                      ),
                    ],
                  ),
                  const Divider(),

                  // total expense
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Total expense'),
                      Text(
                        '${cubit.totalExpense}',
                      ),
                    ],
                  ),

                  const Divider(),

                  // net profit
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Net profit'),
                      Text(
                        '${cubit.netProfit}',
                      ),
                    ],
                  ),
                  const Divider(),

                  const Gap(50),

                  // admin profit
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Administration profit'),
                      Text(
                        '${cubit.adminProfit}',
                      ),
                    ],
                  ),

                  const Divider(),

                  // person net profit
                  ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      String key = cubit.keys[index];
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(key),
                          const Gap(10),
                          Text(
                            '${cubit.personNetProfit[key]}',
                          ),
                        ],
                      );
                    },
                    separatorBuilder: (context, index) => const Divider(),
                    itemCount: cubit.keys.length,
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
