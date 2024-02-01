import 'package:calculator/core/functions.dart';
import 'package:calculator/features/home/cubit/calculator_cubit.dart';
import 'package:calculator/features/home/cubit/calculator_state.dart';
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
          'Output Screen',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
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
                  // date
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Date',
                        style: getTextStyle(),
                      ),
                      Text(
                        getCurrentDate(),
                        style: getTextStyle(),
                      ),
                    ],
                  ),

                  const Divider(),
                  // total profit
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Total profit',
                        style: getTextStyle(),
                      ),
                      Text(
                        '${cubit.totalProfit}',
                        style: getTextStyle(),
                      ),
                    ],
                  ),
                  const Divider(),

                  // total expense
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Total expense',
                        style: getTextStyle(),
                      ),
                      Text(
                        '${cubit.totalExpense}',
                        style: getTextStyle(),
                      ),
                    ],
                  ),

                  const Divider(),

                  // net profit
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Net profit',
                        style: getTextStyle(),
                      ),
                      Text(
                        '${cubit.netProfit}',
                        style: getTextStyle(),
                      ),
                    ],
                  ),
                  const Divider(),

                  const Gap(50),

                  // admin profit
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Administration',
                        style: getTextStyle(),
                      ),
                      Text(
                        '${cubit.adminProfit}',
                        style: getTextStyle(),
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
                          Text(
                            key,
                            style: getTextStyle(),
                          ),
                          const Gap(10),
                          Text(
                            '${cubit.personNetProfit[key]}',
                            style: getTextStyle(),
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
