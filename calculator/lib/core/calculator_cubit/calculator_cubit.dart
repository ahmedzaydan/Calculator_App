import 'package:calculator/core/calculator_cubit/calculator_state.dart';
import 'package:calculator/core/models/person_model.dart';
import 'package:calculator/core/models/profit_model.dart';
import 'package:calculator/core/resources/strings_manager.dart';
import 'package:calculator/core/utils/cache_controller.dart';
import 'package:calculator/core/utils/functions.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CalculatorCubit extends Cubit<CalculatorState> {
  CalculatorCubit() : super(CalculatorInitial());

  static CalculatorCubit get(context) => BlocProvider.of(context);

  String checkedProfits = '';
  String expenses = '';
  String note = '';

  double totalProfit = 0.0;
  double totalExpense = 0.0;
  double netProfit = 0.0;
  double adminPercentage = 0.0;
  double adminProfit = 0.0;

  List<ProfitModel> profitItems = [];
  List<PersonModel> personItems = [];

  void loadProfitItem(String key) {
    if (!key.contains(StringsManager.status)) {
      ProfitModel profit = ProfitModel(
        id: key,
        value: CacheController.getDoubleData(key)!,
        isChecked: CacheController.getBoolData('$key${StringsManager.status}')!,
      );
      profitItems.add(profit);
    }
  }

  void loadPersonItem(String key) {
    PersonModel person = PersonModel(
      name: key,
      percentage: CacheController.getDoubleData(key)!,
    );
    personItems.add(person);
  }

  void handleAdminPercentage(String key) {
    // check if admin has stored percentage
    if (CacheController.checkKey(key: key)) {
      adminPercentage = CacheController.getDoubleData(key)!;
    } else {
      // default admin percentage
      adminPercentage = 30;

      // save the default admin percentage
      CacheController.saveData(key, adminPercentage);
    }
  }

  void loadData() {
    profitItems.clear();
    personItems.clear();
    checkedProfits = '';

    List<String> keys = CacheController.getKeys();
    if (kDebugMode) {
      print("keys: $keys");
    }
    for (var key in keys) {
      if (key.startsWith('#')) {
        loadProfitItem(key);
      } else if (key == StringsManager.admin) {
        handleAdminPercentage(key);
      } else {
        loadPersonItem(key);
      }
    }
    sortProfits();
    emit(DataLoadedSuccessState());
  }

  void calculateProfit() {
    totalProfit = 0;
    checkedProfits = '';
    for (var profit in profitItems) {
      if (profit.isChecked) {
        totalProfit += profit.value;
        checkedProfits += profit.outputProfitKey;
      }
    }
    if (checkedProfits.isNotEmpty) {
      checkedProfits = checkedProfits.substring(0, checkedProfits.length - 4);
    }
    totalProfit = roundDouble(totalProfit);
  }

  void calculateExpense() {
    totalExpense = 0.0;
    List<String> expenseValues = expenses.split(',');
    for (var i = 0; i < expenseValues.length; i++) {
      if (expenseValues[i].isNotEmpty) {
        totalExpense += double.parse(expenseValues[i]);
      }
    }
    totalExpense = roundDouble(totalExpense);
  }

  void calculate() {
    calculateProfit();
    calculateExpense();
    adminProfit = totalProfit * (adminPercentage / 100);
    netProfit = roundDouble(totalProfit - totalExpense - adminProfit);
    adminProfit = roundDouble(adminProfit);

    // calculate person net profits
    for (var person in personItems) {
      person.calculateNetProfitValue(netProfit);
    }
    emit(CalculateState());
  }

  /// settings screen

  /// person functions ******************************************************
  Future<void> addPerson({
    required String name,
    required double percentage,
  }) async {
    // check if perecentage is valid or not
    if (percentage < 0 || percentage > 100) {
      emit(AddPersonErrorState(StringsManager.invalidPercentage));
      return;
    }

    // check if total percentage is less than 100
    double totalPercentage = 0;
    for (var person in personItems) {
      totalPercentage += person.netProfitValue;
    }

    if (totalPercentage + percentage > 100) {
      emit(AddPersonErrorState(StringsManager.percentageError));
      return;
    }

    // check if person name already exists
    if (CacheController.checkKey(key: name)) {
      emit(AddPersonErrorState(StringsManager.personExists));
      return;
    }

    // create person object
    PersonModel person = PersonModel(
      name: name,
      percentage: percentage,
    );

    // add person to the personItems list
    personItems.add(person);

    // add person to shared preferences
    await CacheController.saveData(person.name, person.percentage);

    emit(AddPersonSuccessState());
  }

  void savePersonsData() {
    // save admin data
    CacheController.saveData(StringsManager.admin, adminPercentage);

    // save persons data
    for (var person in personItems) {
      CacheController.saveData(person.name, person.percentage);
    }
    emit(PersonsDataSavedState());
  }

  Future<void> deletePerson(int index) async {
    PersonModel person = personItems[index];

    // remove person from shared preferences
    await CacheController.removeData(key: person.name);

    // remove person from the personItems list
    personItems.removeAt(index);
    emit(DeletePersonState());
  }

  void editPersonPercentage({
    required int index,
    required String value,
  }) {
    personItems[index].setPercentage(double.parse(value));
  }

  /// profit functions *******************************************************
  Future<void> addProfitItem({
    required String id,
    required double value,
  }) async {
    if (!CacheController.checkKey(key: '#$id')) {
      // create profit object
      ProfitModel profit = ProfitModel(
        id: '#$id',
        value: value,
      );

      // add profit to the profitItems list
      profitItems.add(profit);

      // add profit to shared preferences
      await CacheController.saveData(profit.id, profit.value);
      await CacheController.saveData(profit.statusId, false);

      sortProfits();
      emit(AddProfitSuccessState());
    } else {
      emit(
        AddProfitFailedState(StringsManager.profitExists),
      );
    }
  }

  Future<void> changeProfitStatus(int index) async {
    profitItems[index].toggleStatus();
    await CacheController.saveData(
      profitItems[index].statusId,
      profitItems[index].isChecked,
    );
    emit(ProfitStatusChangedState());
  }

  Future<void> editProfitValue({
    required int index,
    required String value,
  }) async {
    profitItems[index].setValue(double.parse(value));
    await CacheController.saveData(
      profitItems[index].id,
      profitItems[index].value,
    );
  }

  Future<void> saveProfitData() async {
    for (var profit in profitItems) {
      // save profit data to shared preferences
      await CacheController.saveData(profit.id, profit.value);
    }
    sortProfits();
    emit(ProfitsDataSavedState());
  }

  Future<void> deleteProfitItem(int index) async {
    await CacheController.removeData(key: profitItems[index].id);
    await CacheController.removeData(key: profitItems[index].statusId);
    profitItems.removeAt(index);
    sortProfits();
    emit(DeleteProfitSuccessState());
  }

  Future<void> clearProfitItems() async {
    for (ProfitModel profit in profitItems) {
      profit.setStatus(false);
      await CacheController.saveData(profit.statusId, false);
    }
    emit(ClearProfitItemsState());
  }

  void sortProfits() {
    profitItems.sort(
      (a, b) {
        int aIndex = int.parse(a.id.substring(1));
        int bIndex = int.parse(b.id.substring(1));
        return aIndex.compareTo(bIndex);
      },
    );
    emit(ProfitKeysSortedState());
  }
}
