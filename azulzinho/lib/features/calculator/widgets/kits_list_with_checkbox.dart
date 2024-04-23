import 'package:azulzinho/app/utils/dependency_injection.dart';
import 'package:azulzinho/app/widgets/custom_list_view.dart';
import 'package:azulzinho/features/app_layout/app_layout_cubit/app_states.dart';
import 'package:azulzinho/features/calculator/calculator_cubit/calculator_cubit.dart';
import 'package:azulzinho/features/calculator/widgets/kit_with_checkbox.dart';
import 'package:azulzinho/features/kits/kit_cubit/kit_cubit.dart';
import 'package:azulzinho/features/kits/models/kit_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class KitsListWithCheckbox extends StatelessWidget {
  KitsListWithCheckbox({
    super.key,
  });

  final CalculatorCubit cubit = locator<CalculatorCubit>();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<KitsCubit, AppStates>(
      builder: (_, __) {
        var kitsCubit = locator<KitsCubit>();
        return Visibility(
          visible: !cubit.isKitsListCollapsed,
          child: CustomListView(
            itemBuilder: (_, index) {
              KitModel kit = kitsCubit.kits[index];
              return KitWithCheckbox(
                kit: kit,
                onChanged: (_) async {
                  await kitsCubit.toggleKitIsChecked(kit);
                },
              );
            },
            separatorBuilder: (_, index) => const Gap(5),
            itemCount: kitsCubit.kits.length,
          ),
        );
      },
    );
  }
}
