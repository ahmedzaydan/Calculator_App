import 'package:calculator/app/resources/color_manager.dart';
import 'package:calculator/app/resources/constants_manager.dart';
import 'package:calculator/app/resources/values_manager.dart';
import 'package:calculator/app/utils/dependency_injection.dart';
import 'package:calculator/app/utils/extensions.dart';
import 'package:calculator/app/utils/functions.dart';
import 'package:calculator/features/kits/kit_cubit/kit_cubit.dart';
import 'package:calculator/features/kits/models/kit_model.dart';
import 'package:calculator/features/kits/models/kit_type.dart';
import 'package:calculator/features/widgets/actions_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gap/gap.dart';

class KitWidget extends StatelessWidget {
  KitWidget({
    super.key,
    required this.kit,
    this.editOnPressed,
    this.deleteOnPressed,
  });

  final KitModel kit;
  final void Function()? editOnPressed;
  final void Function()? deleteOnPressed;
  final cubit = locator<KitsCubit>();

  @override
  Widget build(BuildContext context) {
    KitType type = cubit.getKitStatus(kit).kitType;
    return Container(
      decoration: BoxDecoration(
        color: type.backgroundColor,
        borderRadius: BorderRadius.circular(ConstantsManager.borderRadius),
        border: Border.all(
          color: ColorManager.black,
          width: 1.5,
        ),
      ),
      padding: const EdgeInsets.symmetric(vertical: AppPadding.p8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // actions + label
          Padding(
            padding: const EdgeInsets.only(
              left: AppPadding.p20,
              right: AppPadding.p18,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  flex: 4,
                  child: Text(type.typeString, style: getTextStyle()),
                ),

                // edit and delete buttons
                Expanded(
                  flex: 1,
                  child: ActionsWidget(
                    editOnPressed: editOnPressed,
                    deleteOnPressed: deleteOnPressed,
                  ),
                ),
              ],
            ),
          ),

          const Gap(2),

          // kit name + value
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppPadding.p20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // kit name
                Text(kit.name, style: getTextStyle()),

                // kit value
                Text('${kit.value}', style: getTextStyle()),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
