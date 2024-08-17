import 'package:azulzinho/core/resources/strings_manager.dart';
import 'package:azulzinho/core/resources/values_manager.dart';
import 'package:azulzinho/core/utils/dependency_injection.dart';
import 'package:azulzinho/core/utils/extensions.dart';
import 'package:azulzinho/core/widgets/custom_divider.dart';
import 'package:azulzinho/core/widgets/custom_list_view.dart';
import 'package:azulzinho/core/widgets/item_widgets/info_item.dart';
import 'package:azulzinho/features/persons/models/person_model.dart';
import 'package:azulzinho/features/persons/person_cubit/persons_cubit.dart';
import 'package:azulzinho/themes/color_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ResultsSection extends StatelessWidget {
  const ResultsSection({super.key});

  @override
  Widget build(BuildContext context) {
    var cubit = locator<PersonsCubit>();
    return Container(
      decoration: const BoxDecoration(),
      child: Padding(
        padding: EdgeInsets.only(
          top: 0,
          bottom: AppPadding.p8.h,
          left: AppPadding.p8.w,
          right: AppPadding.p8.w,
        ),
        child: Column(
          children: [
            // Admin
            InfoItem(
              label: PersonsStrings.admin,
              value: cubit.admin.shareValue.toString().currency,
              labelColor: ColorManager.red,
              valueColor: ColorManager.red,
            ),

            CustomDivider(),

            // Person net profit
            CustomListView(
              itemBuilder: (context, index) {
                PersonModel person = cubit.personItems[index];
                return InfoItem(
                  label: person.name,
                  value: person.shareValue.toString().currency,
                  valueColor: Color.fromARGB(255, 5, 80, 5),
                  labelColor: Color.fromARGB(255, 5, 80, 5),
                );
              },
              separatorBuilder: (context, index) => CustomDivider(),
              itemCount: cubit.personItems.length,
            ),
          ],
        ),
      ),
    );
  }
}
