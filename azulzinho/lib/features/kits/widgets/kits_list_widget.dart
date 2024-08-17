import 'package:azulzinho/core/resources/strings_manager.dart';
import 'package:azulzinho/core/utils/extensions.dart';
import 'package:azulzinho/core/utils/functions.dart';
import 'package:azulzinho/core/widgets/collapse_button.dart';
import 'package:azulzinho/core/widgets/custom_alert_dialog.dart';
import 'package:azulzinho/core/widgets/custom_list_view.dart';
import 'package:azulzinho/core/widgets/item_widgets/data_item.dart';
import 'package:azulzinho/features/kits/kit_cubit/kit_cubit.dart';
import 'package:azulzinho/features/kits/models/kit_model.dart';
import 'package:azulzinho/features/kits/views/edit_kit_view.dart';
import 'package:azulzinho/features/kits/views/renew_expired_kit_view.dart';
import 'package:azulzinho/features/kits/widgets/kits_list_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';

class KitsListWidget extends StatelessWidget {
  KitsListWidget({
    super.key,
    required this.list,
    required this.title,
    this.collapseOnPressed,
    this.isCollapsed = false,
  });

  final List<KitModel> list;
  final String title;
  final void Function()? collapseOnPressed;
  final bool isCollapsed;

  @override
  Widget build(BuildContext context) {
    var cubit = KitsCubit.of(context);

    return Column(
      children: [
        KitsListHeader(
          title: title,
          counter: list.length.toString(),
          collapseButton: CollapseButton(
            isCollapsed: isCollapsed,
            onPressed: collapseOnPressed,
          ),
        ),

        Gap(20.h),

        // If the list is not empty, show the list
        if (list.isNotEmpty) ...[
          Visibility(
            visible: !isCollapsed,
            child: CustomListView(
              itemBuilder: (_, index) {
                KitModel kit = list[index];
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
                      onOk: () async {
                        await cubit.deleteKit(kit);
                      },
                    );
                  },
                );
              },
              itemCount: list.length,
              separatorBuilder: (context, index) => Gap(10.h),
            ),
          ),
          isCollapsed ? const Gap(0) : Gap(50.h),
        ],
      ],
    );
  }
}
