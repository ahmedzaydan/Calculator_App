import 'package:azulzinho/core/utils/extensions.dart';
import 'package:azulzinho/core/utils/functions.dart';
import 'package:azulzinho/core/widgets/add_list_tile.dart';
import 'package:azulzinho/core/widgets/collapse_button.dart';
import 'package:azulzinho/core/widgets/custom_alert_dialog.dart';
import 'package:azulzinho/core/widgets/custom_expansion_tile.dart';
import 'package:azulzinho/core/widgets/custom_list_view.dart';
import 'package:azulzinho/core/widgets/item_widgets/data_item.dart';
import 'package:azulzinho/features/kits/kit_cubit/kit_cubit.dart';
import 'package:azulzinho/features/kits/models/kit_model.dart';
import 'package:azulzinho/features/kits/views/add_kit_view.dart';
import 'package:azulzinho/features/kits/views/edit_kit_view.dart';
import 'package:azulzinho/features/kits/views/renew_expired_kit_view.dart';
import 'package:azulzinho/themes/strings_manager.dart';
import 'package:azulzinho/themes/styles_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';

class KitsViewBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var cubit = KitsCubit.of(context);

    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 14.w,
          vertical: 24.h,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // add kit inkwell
            AddListTile(
              text: KitsStrings.addKit,
              onTap: () {
                navigateTo(
                  context: context,
                  dest: AddKitView(),
                );
              },
            ),

            Gap(20.h),

            CustomListView(
              itemBuilder: (context, i) {
                return CustomExpansionTile(
                  title: Text(
                    cubit.listsTitles[i],
                    style: getBoldStyle(),
                  ),
                  children: [
                    CustomListView(
                      itemBuilder: (_, index) {
                        KitModel kit = cubit.getCollapsableList(i)[index];

                        return DataItem(
                          color: kit.status!.kitType.backgroundColor,
                          name: kit.name,
                          actionIcon: kit.status == KitStatus.expired
                              ? FontAwesomeIcons.rotate
                              : FontAwesomeIcons.pen,
                          value: '${kit.value} R\$',
                          onActionPressed: () {
                            navigateTo(
                              context: context,
                              dest: kit.status == KitStatus.expired
                                  ? RenewExpiredKitView(kit: kit)
                                  : EditKitView(kit: kit),
                            );
                          },
                          deleteOnPressed: () async {
                            showCustomAlertDialog(
                              context: context,
                              message: KitsStrings.deleteConfirmation,
                              onOk: () => cubit.deleteKit(kit),
                            );
                          },
                        );
                      },
                      itemCount: cubit.getCollapsableList(i).length,
                      separatorBuilder: (context, index) => Gap(10.h),
                    ),
                  ],
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Counter
                      Text(
                        '${cubit.getCollapsableList(i).length}',
                        style: getBoldStyle(),
                      ),
                      Gap(10.w),
                      CollapseButton(
                        isCollapsed: cubit.collapsedLists[i],
                      ),
                    ],
                  ),
                );
              },
              itemCount: 5,
              withSeparator: false,
            ),
          ],
        ),
      ),
    );
  }
}
