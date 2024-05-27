import 'package:azulzinho/themes/color_manager.dart';
import 'package:azulzinho/core/resources/strings_manager.dart';
import 'package:azulzinho/themes/styles_manager.dart';
import 'package:azulzinho/core/resources/values_manager.dart';
import 'package:azulzinho/core/utils/dependency_injection.dart';
import 'package:azulzinho/core/widgets/custom_list_view.dart';
import 'package:azulzinho/core/widgets/data_item.dart';
import 'package:azulzinho/features/app_layout/app_layout_cubit/app_states.dart';
import 'package:azulzinho/features/kits/kit_cubit/kit_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class HistoryView extends StatelessWidget {
  HistoryView({super.key});

  final cubit = locator<KitsCubit>();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<KitsCubit, AppStates>(
      builder: (context, state) {
        return SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(
              vertical: AppPadding.p20.h,
              horizontal: AppPadding.p14.w,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title
                Text(
                  KitsStrings.historyTitle,
                  style: TextStylesManager.textStyle26.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),

                Gap(40.h),

                CustomListView(
                  itemBuilder: (context, index) {
                    return DataItem(
                      color: ColorManager.expired,
                      name: cubit.expiredKits[index].name,
                      value: cubit.expiredKits[index].value.toString(),
                      isEditVisible: false,
                      isDeleteVisible: false,
                    );
                  },
                  itemCount: cubit.expiredKits.length,
                  separatorBuilder: (context, index) => Gap(20.h),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
