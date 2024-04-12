import 'package:calculator/app/resources/strings_manager.dart';
import 'package:calculator/app/resources/styles_manager.dart';
import 'package:calculator/app/utils/dependency_injection.dart';
import 'package:calculator/app/widgets/custom_divider.dart';
import 'package:calculator/app/widgets/custom_list_view.dart';
import 'package:calculator/features/persons/models/person_model.dart';
import 'package:calculator/features/persons/person_cubit/persons_cubit.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class ResultsSection extends StatelessWidget {
  const ResultsSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var cubit = locator<PersonsCubit>();
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
            _adminProfit(),

            const CustomDivider(),

            const Gap(30),

            // person net profit
            CustomListView(
              itemBuilder: (context, index) {
                PersonModel person = cubit.personItems[index];
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      person.name,
                      style: TextStylesManager.textStyle26,
                    ),
                    const Gap(10),
                    Text(
                      '${person.shareValue}',
                      style: TextStylesManager.textStyle26,
                    ),
                  ],
                );
              },
              separatorBuilder: (context, index) {
                return const CustomDivider();
              },
              itemCount: cubit.personItems.length,
            ),
          ],
        ),
      ),
    );
  }

  Row _adminProfit() {
    var cubit = locator<PersonsCubit>();
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          PersonsStrings.admin,
          style: TextStylesManager.textStyle28,
        ),
        Text(
          '${cubit.adminProfit}',
          style: TextStylesManager.textStyle28,
        ),
      ],
    );
  }
}
