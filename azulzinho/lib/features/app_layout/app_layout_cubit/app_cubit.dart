import 'package:azulzinho/app/resources/strings_manager.dart';
import 'package:azulzinho/features/app_layout/app_layout_cubit/app_states.dart';
import 'package:azulzinho/features/calculator/calculator_cubit/calculator_cubit.dart';
import 'package:azulzinho/features/calculator/views/calculator_view.dart';
import 'package:azulzinho/features/kits/kit_cubit/kit_cubit.dart';
import 'package:azulzinho/features/kits/views/history_view.dart';
import 'package:azulzinho/features/kits/views/kits_view.dart';
import 'package:azulzinho/features/persons/person_cubit/persons_cubit.dart';
import 'package:azulzinho/features/persons/views/persons_view.dart';
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

  List<String> personKeys = [];

  Future<void> init() async {
    try {
      emit(LoadingDataState());
      await kitsCubit.fetchData();
      await personsCubit.fetchData();
    } catch (e) {
      emit(LoadingDataErrorState(StringsManager.dataLoadingError));
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
    emit(ChangeBottomNavIndexState(index));
  }
}
