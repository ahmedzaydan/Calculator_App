import 'package:calculator/core/cache_controller.dart';
import 'package:calculator/core/calculator_cubit/calculator_state.dart';
import 'package:calculator/core/functions.dart';
import 'package:calculator/core/resources/strings_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CalculatorCubit extends Cubit<CalculatorState> {
  CalculatorCubit() : super(CalculatorInitial());

  static CalculatorCubit get(context) => BlocProvider.of(context);
  String checked = 'checked';

  double totalProfit = 0.0;
  List<String> profitKeys = [];
  Map<String, double> profits = {};
  Map<String, bool> profitItemStates = {};
  String checkedProfits = '';

  double totalExpense = 0.0;
  String expenses = '';

  double netProfit = 0;
  String note = '';

  double adminPercentage = 0;
  List<String> personKeys = [];
  Map<String, double> persons = {};

  List<TextFormField> personFields = [];
  double adminProfit = 0.0;
  Map<String, double> personNetProfit = {};

  void loadData() {
    profitKeys = [];
    profits = {};
    profitItemStates = {};
    checkedProfits = '';
    personKeys = [];
    persons = {};
    personFields = [];
    personNetProfit = {};

    List<String> keys = CacheController.getKeys();
    // separte the keys into two lists, profit list and person list
    for (var key in keys) {
      if (key.startsWith('#c') || key.startsWith('#')) {
        String newKey = '';
        if (key.startsWith('#c')) {
          newKey = key.substring(8);
        } else {
          newKey = key.substring(1);
        }

        profitKeys.add(key);
        double? value = CacheController.getData(key: key)!.toDouble();
        profits[newKey] = value;

        profitItemStates[newKey] = (key.startsWith('#$checked'));
      } else {
        if (key == 'admin') {
          adminPercentage = CacheController.getData(key: 'admin')!.toDouble();
        } else {
          personKeys.add(key);
          double? value = CacheController.getData(key: key)!.toDouble();
          persons[key] = value;
        }
      }
    }

    if (adminPercentage == 0) {
      adminPercentage = 30;
      CacheController.saveData(
        key: 'admin',
        value: adminPercentage,
      );
    }

    sortProfits();
    emit(DataLoadedSuccessState());
  }

  void changeProfitStatus(String profitId) async {
    if (profitItemStates[profitId] != null) {
      if (profitItemStates[profitId] == true) {
        profitItemStates[profitId] = false;

        CacheController.removeData(key: '#$checked$profitId');

        await CacheController.saveData(
          key: '#$profitId',
          value: profits[profitId]!,
        );
      } else {
        profitItemStates[profitId] = true;

        CacheController.removeData(key: '#$profitId');

        await CacheController.saveData(
          key: '#checked$profitId',
          value: profits[profitId]!,
        );
      }
      emit(ChangeProfitStatusState());
    }
  }

  void calculate() {
    totalProfit = 0;
    checkedProfits = '';

    for (var key in profitKeys) {
      if (profitItemStates[key] == true && profits[key] != null) {
        totalProfit += profits[key]!;
        checkedProfits += '#$key,   ';
      }
    }
    if (checkedProfits.isNotEmpty) {
      checkedProfits = checkedProfits.substring(0, checkedProfits.length - 4);
    }
    totalProfit = roundDouble(totalProfit);

    totalExpense = 0.0;
    List<String> expenseValues = expenses.split(',');
    for (var i = 0; i < expenseValues.length; i++) {
      if (expenseValues[i].isNotEmpty) {
        totalExpense += double.parse(expenseValues[i]);
      }
    }
    totalExpense = roundDouble(totalExpense);

    adminProfit = totalProfit * (adminPercentage / 100);
    netProfit = roundDouble(totalProfit - totalExpense - adminProfit);
    adminProfit = roundDouble(adminProfit);

    for (var key in personKeys) {
      if (persons[key] != null) {
        personNetProfit[key] = roundDouble(netProfit * (persons[key]! / 100));
      }
    }

    emit(CalculateState());
  }

  /// settings screen
  void savePersonsData() {
    CacheController.saveData(key: 'admin', value: adminPercentage);
    for (var key in personKeys) {
      CacheController.saveData(key: key, value: persons[key]!);
    }
    emit(PersonsDataSavedState());
  }

  void addPerson({
    required String name,
    required double percentage,
  }) async {
    // check if perecentage is valid or not
    if (percentage < 0 || percentage > 100) {
      emit(AddPersonFieldState(StringsManager.invalidPercentage));
      return;
    }

    // check if total percentage is less than 100
    double totalPercentage = 0;
    for (var key in personKeys) {
      if (persons[key] != null) {
        totalPercentage += persons[key]!;
      }
    }

    if (totalPercentage + percentage > 100) {
      emit(AddPersonFieldState(StringsManager.percentageTotalLessThan100));
      return;
    }

    // check if person name already exists
    if (CacheController.checkKey(key: name)) {
      emit(AddPersonFieldState(StringsManager.personExists));
      return;
    }

    // add person to the list
    personKeys.add(name);
    persons[name] = percentage;

    await CacheController.saveData(
      key: name,
      value: percentage,
    );

    emit(AddPersonState());
  }

  Future<void> deletePerson({
    required String name,
    required int index,
  }) async {
    persons.remove(name);
    personKeys.remove(name);
    if (personFields.isNotEmpty) {
      personFields.removeAt(index);
    }

    await CacheController.removeData(key: name);
    emit(DeletePersonState());
  }

  void saveProfitData() async {
    for (var key in profitKeys) {
      String newKey = '';
      if (profitItemStates[key] != null) {
        if (profitItemStates[key] == true) {
          newKey = '#checked$key';
        } else {
          newKey = '#$key';
        }
      }

      if (profits[key] != null) {
        await CacheController.saveData(
          key: newKey,
          value: profits[key]!,
        );
      }
    }
    emit(ProfitsDataSavedState());
  }

  void addProfitItem({
    required String profitId,
    required double value,
  }) async {
    if (!CacheController.checkKey(key: '#$profitId') &&
        !CacheController.checkKey(key: '#checked$profitId')) {
      profitKeys.add(profitId);
      profitItemStates[profitId] = false;
      profits[profitId] = value;

      await CacheController.saveData(
        key: '#$profitId',
        value: value,
      );
      sortProfits();
      emit(AddProfitState());
    } else {
      emit(
        AddProfitFailedState(
          StringsManager.addProfitField,
        ),
      );
    }
  }

  Future<void> deleteProfitItem({
    required String profitId,
  }) async {
    profits.remove(profitId);
    profitKeys.remove(profitId);
    await CacheController.removeData(key: profitId);
    sortProfits();
    emit(DeleteProfitState());
  }

  Future<void> clearProfitItems() async {
    for (var key in profitKeys) {
      if (profitItemStates[key] != null) {
        if (profitItemStates[key] == true) {
          CacheController.removeData(key: '#checked$key');
          if (profits[key] != null) {
            await CacheController.saveData(
              key: '#$key',
              value: profits[key]!,
            );
          }
        }
      }
      profitItemStates[key] = false;
    }
    emit(ClearProfitItemsState());
  }

  void sortProfits() {
    // Step 1: Remove '#' at the beginning of each key and convert to integers
    List<int> modifiedKeys =
        profitKeys.map((key) => int.parse(key)).toList();

    // Step 2: Sort the modified keys based on integers
    modifiedKeys.sort();

    // Step 3: Add '#' back to each key in the sorted list
    profitKeys.clear();
    profitKeys = modifiedKeys.map((key) => '$key').toList();
    emit(ProfitKeysSortedState());
  }
}
