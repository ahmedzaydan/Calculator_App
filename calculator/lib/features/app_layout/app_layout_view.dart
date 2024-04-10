import 'package:calculator/app/resources/color_manager.dart';
import 'package:calculator/app/utils/dependency_injection.dart';
import 'package:calculator/features/app_layout/app_layout_cubit/app_cubit.dart';
import 'package:calculator/features/app_layout/app_layout_cubit/app_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppLayout extends StatelessWidget {
  const AppLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubit, AppStates>(
      builder: (_, __) {
        var cubit = locator<AppCubit>();
        return SafeArea(
          child: Scaffold(
            // appBar: cubit.appBars[cubit.currentIndex],
            body: cubit.screens[cubit.currentIndex],
            bottomNavigationBar: BottomNavigationBar(
              items: cubit.bottomNavItems,
              currentIndex: cubit.currentIndex,
              onTap: (index) {
                cubit.changeIndex(index);
              },
              selectedItemColor: ColorManager.primary,
              unselectedItemColor: ColorManager.lightGrey,
            ),
          ),
        );
      },
    );
  }
}
