import 'package:calculator/app/resources/strings_manager.dart';
import 'package:calculator/features/app_layout/app_layout_cubit/app_layout_states.dart';
import 'package:calculator/features/home/views/home_view.dart';
import 'package:calculator/features/kits/views/kits_view.dart';
import 'package:calculator/features/persons/views/persons_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppLayoutCubit extends Cubit<AppLayoutStates> {
  AppLayoutCubit() : super(AppLayoutInitialState());

  final List<AppBar> appBars = [
    // home
    AppBar(title: const Text(StringsManager.homeScreen)),

    // kits
    AppBar(title: const Text(StringsManager.kitsScreen)),

    // persons
    AppBar(title: const Text(StringsManager.personsScreen)),
  ];

  int currentIndex = 0;

  final List<Widget> screens = [
    HomeView(),
    const KitsView(),
    const PersonsView(),
  ];

  final List<BottomNavigationBarItem> bottomNavItems = [
    // home
    const BottomNavigationBarItem(
      icon: Icon(Icons.home),
      label: StringsManager.homeScreen,
    ),

    // kits
    const BottomNavigationBarItem(
      icon: Icon(Icons.monetization_on),
      label: StringsManager.kitsScreen,
    ),

    // persons
    const BottomNavigationBarItem(
      icon: Icon(Icons.person),
      label: StringsManager.personsScreen,
    ),
  ];

  void changeIndex(int index) {
    currentIndex = index;
    emit(ChangeBottomNavIndexState(index));
  }
}
