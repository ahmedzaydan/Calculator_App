import 'dart:developer';

import 'package:calculator/app/resources/strings_manager.dart';
import 'package:calculator/app/utils/cache_controller.dart';
import 'package:calculator/features/app_layout/app_layout_cubit/app_states.dart';
import 'package:calculator/features/calculator/calculator_cubit/calculator_cubit.dart';
import 'package:calculator/features/calculator/views/calculator_view.dart';
import 'package:calculator/features/kits/kit_cubit/kit_cubit.dart';
import 'package:calculator/features/kits/views/history_view.dart';
import 'package:calculator/features/kits/views/kits_view.dart';
import 'package:calculator/features/persons/person_cubit/persons_cubit.dart';
import 'package:calculator/features/persons/views/persons_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit(
    this.calculatorCubit,
    this.personsCubit,
    this.kitsCubit,
  ) : super(AppLayoutInitialState());

  final CalculatorCubit calculatorCubit;
  final PersonsCubit personsCubit;
  final KitsCubit kitsCubit;

  List<String> kitsKeys = [];
  List<String> personKeys = [];

  Future<void> init() async {
    try {
      emit(LoadingDataState());

      getKeys();

      await kitsCubit.loadData(kitsKeys);
      await personsCubit.loadData(personKeys);
    } catch (e) {
      emit(LoadingDataErrorState(StringsManager.dataLoadingError));
    }
  }

  void getKeys() {
    List<String> keys = Prefs.getAllKeys();
    kitsKeys.clear();
    personKeys.clear();

    for (var key in keys) {
      if (key == personsCubit.amdinKey) {
        continue;
      } else if (key.startsWith(kitsCubit.kitKeyPrefix) ||
          key.startsWith(kitsCubit.expiredKitKeyPrefix)) {
        kitsKeys.add(key);
      } else {
        personKeys.add(key);
      }
    }
  }

  int currentIndex = 1;

  final List<Widget> screens = [
    CalculatorView(),
    const KitsView(),
    HistoryView(),
    const PersonsView(),
  ];

  final List<BottomNavigationBarItem> bottomNavItems = [
    // calculator
    const BottomNavigationBarItem(
      icon: FaIcon(FontAwesomeIcons.calculator),
      label: CalculatorStrings.calculatorScreen,
    ),

    // kits
    const BottomNavigationBarItem(
      icon: FaIcon(FontAwesomeIcons.users),
      label: KitsStrings.kitsScreen,
    ),

    // // history
    const BottomNavigationBarItem(
      icon: FaIcon(FontAwesomeIcons.clockRotateLeft),
      label: KitsStrings.history,
    ),

    // persons
    const BottomNavigationBarItem(
      icon: FaIcon(FontAwesomeIcons.briefcase),
      label: PersonsStrings.personsScreen,
    ),
  ];

  void changeIndex(int index) {
    currentIndex = index;

    // load kits data
    if (currentIndex == 1) {
      log('Test');
      getKeys();
      kitsCubit.loadData(kitsKeys);
    }

    // load persons data
    else if (currentIndex == 3) {
      getKeys();
      personsCubit.loadData(personKeys);
    }

    emit(ChangeBottomNavIndexState(index));
  }
}
