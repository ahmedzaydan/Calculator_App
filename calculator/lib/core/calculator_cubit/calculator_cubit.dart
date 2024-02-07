import 'package:calculator/core/calculator_cubit/calculator_state.dart';
import 'package:calculator/core/models/person_model.dart';
import 'package:calculator/core/models/profit_model.dart';
import 'package:calculator/core/resources/strings_manager.dart';
import 'package:calculator/core/utils/cache_controller.dart';
import 'package:calculator/core/utils/functions.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CalculatorCubit extends Cubit<CalculatorState> {
  CalculatorCubit() : super(CalculatorInitial());

  static CalculatorCubit get(context) => BlocProvider.of(context);

  double totalProfit = 0.0;
  String checkedProfits = '';
  List<ProfitModel> profitItems = [];

  double totalExpense = 0.0;
  String expenses = '';

  double netProfit = 0;
  String note = '';

  double adminPercentage = 0;
  double adminProfit = 0.0;

  List<PersonModel> personItems = [];

  void loadProfitItem(String key) {
    ProfitModel profit = ProfitModel();
    profit.setProfitKey(key);
    profit.setValue(
      CacheController.getData(
        key: profit.getSharedPrefKey(),
      )!,
    );
    profitItems.add(profit);
  }

  void loadPersonItem(String key) {
    PersonModel person = PersonModel();
    person.setName(key);
    person.setPercentage(
      CacheController.getData(
        key: person.name,
      )!,
    );
  }

  void handleAdminPercentage(String key) {
    // check if admin has stored percentage
    if (CacheController.checkKey(key: key)) {
      adminPercentage = CacheController.getData(key: key)!;
    } else {
      // default admin percentage
      adminPercentage = 30;

      // save the default admin percentage
      CacheController.saveData(
        key: key,
        value: adminPercentage,
      );
    }
  }

  void loadData() {
    profitItems.clear();
    personItems.clear();
    checkedProfits = '';

    List<String> keys = CacheController.getKeys();
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
      if (profit.status) {
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
  void addPerson({
    required String name,
    required double percentage,
  }) async {
    // check if perecentage is valid or not
    if (percentage < 0 || percentage > 100) {
      emit(
        AddPersonErrorState(
          StringsManager.invalidPercentage,
        ),
      );
      return;
    }

    // check if total percentage is less than 100
    double totalPercentage = 0;
    for (var person in personItems) {
      totalPercentage += person.netProfitValue;
    }

    if (totalPercentage + percentage > 100) {
      emit(
        AddPersonErrorState(
          StringsManager.percentageTotalLessThan100,
        ),
      );
      return;
    }

    // check if person name already exists
    if (CacheController.checkKey(key: name)) {
      emit(
        AddPersonErrorState(
          StringsManager.personExists,
        ),
      );
      return;
    }

    // create person object
    PersonModel person = PersonModel();
    person.setName(name);
    person.setPercentage(percentage);

    // add person to the personItems list
    personItems.add(person);

    // add person to shared preferences
    await CacheController.saveData(
      key: person.name,
      value: person.percentage,
    );

    emit(AddPersonSuccessState());
  }

  void savePersonsData() {
    // save admin data
    CacheController.saveData(
      key: StringsManager.admin,
      value: adminPercentage,
    );

    // save persons data
    for (var person in personItems) {
      CacheController.saveData(
        key: person.name,
        value: person.percentage,
      );
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
  void addProfitItem({
    required String id,
    required double value,
  }) async {
    if (!CacheController.checkKey(key: '#$id') &&
        !CacheController.checkKey(key: '#${StringsManager.checked}$id')) {
      // create profit object
      ProfitModel profit = ProfitModel();
      profit.setProfitKey(id);
      profit.setValue(value);

      // add profit to the profitItems list
      profitItems.add(profit);

      // add profit to shared preferences
      await CacheController.saveData(
        key: profit.uncheckedId,
        value: profit.value,
      );

      sortProfits();
      emit(AddProfitSuccessState());
    } else {
      emit(
        AddProfitFailedState(StringsManager.profitExists),
      );
    }
  }

  void changeProfitStatus(int index) async {
    ProfitModel profit = profitItems[index];
    await deleteProfitFromSharedPref(profit);

    profit.toggleStatus();

    await CacheController.saveData(
      key: profit.getSharedPrefKey(),
      value: profit.value,
    );
    emit(ProfitStatusChangedState());
  }

  void editProfitValue({
    required int index,
    required String value,
  }) {
    profitItems[index].setValue(double.parse(value));
  }

  void saveProfitData() async {
    for (var profit in profitItems) {
      await deleteProfitFromSharedPref(profit);

      // save profit data to shared preferences
      await CacheController.saveData(
        key: profit.getSharedPrefKey(),
        value: profit.value,
      );
    }
    sortProfits();
    emit(ProfitsDataSavedState());
  }

  Future<void> deleteProfitItem(int index) async {
    await deleteProfitFromSharedPref(profitItems[index]);
    profitItems.removeAt(index);
    sortProfits();
    emit(DeleteProfitSuccessState());
  }

  Future<void> deleteProfitFromSharedPref(ProfitModel profit) async {
    // delete checked key from shared preferences (#checkedkey)
    await CacheController.removeData(key: profit.checkedId);

    // delete unchecked key from shared preferences (#key)
    await CacheController.removeData(key: profit.uncheckedId);
  }

  Future<void> clearProfitItems() async {
    for (var profit in profitItems) {
      await deleteProfitFromSharedPref(profit);

      profit.setStatus(false);

      // save profit data to shared preferences
      await CacheController.saveData(
        key: profit.getSharedPrefKey(),
        value: profit.value,
      );
    }
    emit(ClearProfitItemsState());
  }

  void sortProfits() {
    profitItems.sort((a, b) => a.id.compareTo(b.id));

    // // Step 1: Remove '#' at the beginning of each key and convert to integers
    // List<int> modifiedKeys = profitItems.map((profit) {
    //   return int.parse(profit.id);
    // }).toList();

    // // Step 2: Sort the modified keys based on integers
    // modifiedKeys.sort();

    // // Step 3: Add '#' back to each key in the sorted list
    // profitKeys.clear();
    // profitKeys = modifiedKeys.map((key) => '$key').toList();
    emit(ProfitKeysSortedState());
  }
}
