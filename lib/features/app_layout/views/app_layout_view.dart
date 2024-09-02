import 'package:azulzinho/core/utils/dependency_injection.dart';
import 'package:azulzinho/features/app_layout/app_layout_cubit/app_cubit.dart';
import 'package:azulzinho/features/app_layout/app_layout_cubit/app_states.dart';
import 'package:azulzinho/themes/color_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppLayoutView extends StatelessWidget {
  const AppLayoutView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubit, AppStates>(
      builder: (_, __) {
        var cubit = locator<AppCubit>();

        return SafeArea(
          child: Scaffold(
            body: cubit.screens[cubit.currentIndex],
            bottomNavigationBar: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              items: cubit.bottomNavItems,
              currentIndex: cubit.currentIndex,
              onTap: (index) => cubit.changeIndex(index),
              selectedItemColor: ColorManager.primary,
              unselectedItemColor: ColorManager.lightGrey,
            ),
          ),
        );
      },
    );
  }
}
