import 'package:azulzinho/app/resources/strings_manager.dart';
import 'package:azulzinho/app/resources/styles_manager.dart';
import 'package:azulzinho/app/resources/values_manager.dart';
import 'package:azulzinho/app/utils/dependency_injection.dart';
import 'package:azulzinho/app/widgets/custom_divider.dart';
import 'package:azulzinho/app/widgets/custom_list_view.dart';
import 'package:azulzinho/features/persons/models/person_model.dart';
import 'package:azulzinho/features/persons/person_cubit/persons_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
        padding: EdgeInsets.symmetric(
          vertical: AppPadding.p8.h,
          horizontal: AppPadding.p8.w,
        ),
        child: Column(
          children: [
            _adminProfit(),

            const CustomDivider(),

            Gap(30.h),

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
                    Gap(10.h),
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
        Text(
          PersonsStrings.admin,
          style: TextStylesManager.textStyle26.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          '${cubit.admin.shareValue}',
          style: TextStylesManager.textStyle26.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
