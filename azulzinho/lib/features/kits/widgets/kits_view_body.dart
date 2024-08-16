// import 'package:azulzinho/core/resources/strings_manager.dart';
// import 'package:azulzinho/core/resources/values_manager.dart';
// import 'package:azulzinho/core/utils/dependency_injection.dart';
// import 'package:azulzinho/core/utils/extensions.dart';
// import 'package:azulzinho/core/utils/functions.dart';
// import 'package:azulzinho/core/widgets/add_list_tile.dart';
// import 'package:azulzinho/core/widgets/collapse_button.dart';
// import 'package:azulzinho/core/widgets/custom_alert_dialog.dart';
// import 'package:azulzinho/core/widgets/custom_expansion_tile.dart';
// import 'package:azulzinho/core/widgets/custom_list_view.dart';
// import 'package:azulzinho/core/widgets/item_widgets/data_item.dart';
// import 'package:azulzinho/core/widgets/item_widgets/edit_item_view.dart';
// import 'package:azulzinho/features/app_layout/app_layout_cubit/app_states.dart';
// import 'package:azulzinho/features/kits/kit_cubit/kit_cubit.dart';
// import 'package:azulzinho/features/kits/views/add_kit_view.dart';
// import 'package:azulzinho/themes/styles_manager.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:gap/gap.dart';

// import '../models/kit_model.dart';

// class KitsViewBody extends StatelessWidget {
//   const KitsViewBody({super.key});

//   @override
//   Widget build(BuildContext context) {
//     var cubit = locator<KitsCubit>();

//     return SingleChildScrollView(
//       child: Padding(
//         padding: EdgeInsets.symmetric(
//           horizontal: AppPadding.p14.w,
//           vertical: AppPadding.p24.h,
//         ),
//         child: BlocBuilder<KitsCubit, AppStates>(
//           builder: (context, state) {
//             return Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 // add kit inkwell
//                 AddListTile(
//                   text: KitsStrings.addKit,
//                   onTap: () {
//                     navigateTo(
//                       context: context,
//                       dest: AddKitView(sourceContext: context),
//                     );
//                   },
//                 ),

//                 Gap(20.h),

//                 CustomListView(
//                   itemBuilder: (_, index) {
//                     return CustomExpansionTile(
//                       isExpanded: cubit.collapsedLists[index],
//                       title: Padding(
//                         padding: EdgeInsets.symmetric(vertical: 10.h),
//                         child: Text(
//                           cubit.listsTitles[index],
//                           style: getBoldStyle(),
//                         ),
//                       ),
//                       children: [
//                         CustomListView(
//                           itemBuilder: (_, index) {
//                             KitModel kit =
//                                 cubit.getCollapsableList(index)[index];
//                             return DataItem(
//                               color: kit.status!.kitType.backgroundColor,
//                               name: kit.name,
//                               value: '${kit.value} R\$',
//                               editOnPressed: () {
//                                 navigateTo(
//                                   context: context,
//                                   dest: EditItemView(
//                                     kitModel: kit,
//                                     label: kit.name,
//                                     value: kit.value,
//                                     updateKit: true,
//                                     sourceContext: context,
//                                     index: index,
//                                   ),
//                                 );
//                               },
//                               deleteOnPressed: () async {
//                                 showCustomAlertDialog(
//                                   context: context,
//                                   message: KitsStrings.deleteConfirmation,
//                                   onOk: () async {
//                                     await cubit.deleteKit(kit);
//                                   },
//                                 );
//                               },
//                             );
//                           },
//                           itemCount: cubit.getCollapsableList(index).length,
//                           separatorBuilder: (context, index) => Gap(10.h),
//                         ),
//                       ],
//                       trailing: Row(
//                         mainAxisSize: MainAxisSize.min,
//                         children: [
//                           // counter
//                           Text(
//                             cubit.getCollapsableList(index).length.toString(),
//                             style: getBoldStyle(),
//                           ),
//                           Gap(10.w),
//                           CollapseButton(
//                             isCollapsed: cubit.collapsedLists[index],
//                             onPressed: () => cubit.toggleListVisibility(index),
//                           ),
//                         ],
//                       ),
//                     );

//                     // return KitsListsWidget(
//                     //   sourceContext: context,
//                     //   list: cubit.getCollapsableList(index),
//                     //   title: cubit.listsTitles[index],
//                     //   isCollapsed: cubit.collapsedLists[index],
//                     //   collapseOnPressed: () => cubit.toggleListVisibility(index),
//                     // );
//                   },
//                   itemCount: 5,
//                   withSeparator: false,
//                 )
//               ],
//             );
//           },
//         ),
//       ),
//     );
//   }
// }

import 'package:azulzinho/core/resources/strings_manager.dart';
import 'package:azulzinho/core/resources/values_manager.dart';
import 'package:azulzinho/core/utils/functions.dart';
import 'package:azulzinho/core/widgets/add_list_tile.dart';
import 'package:azulzinho/features/kits/views/add_kit_view.dart';
import 'package:azulzinho/features/kits/widgets/kits_lists_view.dart';
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
            AddListTile(
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
