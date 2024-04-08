import 'package:calculator/app/resources/strings_manager.dart';
import 'package:calculator/app/utils/cache_controller.dart';
import 'package:calculator/features/app_layout/app_layout_cubit/app_states.dart';
import 'package:calculator/features/calculator/calculator_cubit/calculator_cubit.dart';
import 'package:calculator/features/calculator/views/calculator_view.dart';
import 'package:calculator/features/kits/kit_cubit/kit_cubit.dart';
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
    emit(LoadingDataState());

    getKeys();

    kitsCubit.loadData(kitsKeys).then((_) {
      personsCubit.loadData(personKeys).then((_) {
        emit(LoadingDataSuccessState());
      }).catchError((error) {
        emit(LoadingDataErrorState(StringsManager.dataLoadingError));
      });
    }).catchError((error) {
      emit(LoadingDataErrorState(StringsManager.dataLoadingError));
    });
  }

  void getKeys() {
    List<String> keys = CacheController.getAllKeys();

    for (var key in keys) {
      if (key == personsCubit.amdinKey) {
        continue;
      } else if (key.startsWith(kitsCubit.kitKeyPrefix)) {
        kitsKeys.add(key);
      } else {
        personKeys.add(key);
      }
    }
  }

  final List<AppBar> appBars = [
    // home
    AppBar(title: const Text(StringsManager.calculatorScreen)),

    // kits
    AppBar(title: const Text(StringsManager.kitsScreen)),

    // persons
    AppBar(title: const Text(StringsManager.personsScreen)),
  ];

  int currentIndex = 1;

  final List<Widget> screens = [
    CalculatorView(),
    const KitsView(),
    const PersonsView(),
  ];

  final List<BottomNavigationBarItem> bottomNavItems = [
    // calculator
    const BottomNavigationBarItem(
      icon: FaIcon(FontAwesomeIcons.calculator),
      label: StringsManager.calculatorScreen,
    ),

    // kits
    const BottomNavigationBarItem(
      // TODO: what is the suitable icon for kits?
      icon: FaIcon(FontAwesomeIcons.users),
      label: StringsManager.kitsScreen,
    ),

    // persons
    const BottomNavigationBarItem(
      // TODO: what is the screen title?!
      icon: FaIcon(FontAwesomeIcons.userSecret),
      label: StringsManager.personsScreen,
    ),
  ];

  void changeIndex(int index) {
    currentIndex = index;
    if (currentIndex == 1) {
      getKeys();
      kitsCubit.loadData(kitsKeys);
    } else if (currentIndex == 2) {
      getKeys();
      personsCubit.loadData(personKeys);
    }
    emit(ChangeBottomNavIndexState(index));
  }
}
