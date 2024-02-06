import 'package:calculator/core/calculator_cubit/calculator_cubit.dart';
import 'package:calculator/core/functions.dart';
import 'package:calculator/core/resources/strings_manager.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class ResultsSection extends StatelessWidget {
  const ResultsSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var cubit = CalculatorCubit.get(context);
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage(
            'assets/images/logo.jpg',
          ),
          fit: BoxFit.cover,
          opacity: 0.13,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            // admin profit
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  StringsManager.adminPercentage,
                  style: getTextStyle(),
                ),
                Text(
                  '${cubit.adminProfit}',
                  style: getTextStyle(),
                ),
              ],
            ),

            const Divider(color: Colors.black),

            // person net profit
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                String key = cubit.personKeys[index];
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
              separatorBuilder: (context, index) {
                return const Divider(color: Colors.black);
              },
              itemCount: cubit.personKeys.length,
            ),
          ],
        ),
      ),
    );
  }
}
