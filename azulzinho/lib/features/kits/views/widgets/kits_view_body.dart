import 'package:azulzinho/core/resources/strings_manager.dart';
import 'package:azulzinho/core/resources/values_manager.dart';
import 'package:azulzinho/core/utils/functions.dart';
import 'package:azulzinho/core/widgets/add_item_widget.dart';
import 'package:azulzinho/features/kits/views/add_kit_view.dart';
import 'package:azulzinho/features/kits/views/widgets/kits_lists_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class KitsViewBody extends StatelessWidget {
  const KitsViewBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: AppPadding.p14.w,
          vertical: AppPadding.p24.h,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // add kit inkwell
            AddItemWidget(
              text: KitsStrings.addKit,
              onTap: () {
                navigateTo(
                  context: context,
                  dest: AddKitView(sourceContext: context),
                );
              },
            ),

            Gap(20.h),
            KitsListsView(sourceContext: context),
          ],
        ),
      ),
    );
  }
}
