import 'package:azulzinho/core/resources/strings_manager.dart';
import 'package:azulzinho/core/resources/values_manager.dart';
import 'package:azulzinho/core/utils/dependency_injection.dart';
import 'package:azulzinho/core/widgets/custom_list_view.dart';
import 'package:azulzinho/features/calculator/widgets/report/info_item.dart';
import 'package:azulzinho/features/persons/models/person_model.dart';
import 'package:azulzinho/features/persons/person_cubit/persons_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

// TODO: capture invisble parts also
// capture from long widget constructor

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
            // Admin
            InfoItem(
              label: PersonsStrings.admin,
              value: '${cubit.admin.shareValue}',
            ),

            Divider(),
            Gap(30.h),

            // Person net profit
            CustomListView(
              itemBuilder: (context, index) {
                PersonModel person = cubit.personItems[index];
                return InfoItem(
                  label: person.name,
                  value: person.shareValue.toString(),
                );
              },
              separatorBuilder: (context, index) => const Divider(),
              itemCount: cubit.personItems.length,
            ),
          ],
        ),
      ),
    );
  }
}
