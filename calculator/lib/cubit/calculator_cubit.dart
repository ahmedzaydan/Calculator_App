import 'package:calculator/cache_controller.dart';
import 'package:calculator/cubit/calculator_state.dart';
import 'package:calculator/screens/widgets/custom_text_form_field.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CalculatorCubit extends Cubit<CalculatorState> {
  CalculatorCubit() : super(CalculatorInitial());

  static CalculatorCubit get(context) => BlocProvider.of(context);

  /// home screen
  List<CustomTextFormField> profitFields = [];
  List<double> profitList = [];
  double totalProfit = 0;

  List<CustomTextFormField> expenseFields = [];
  List<double> expenseList = [];
  double totalExpense = 0;

  double netProfit = 0;

  // settings screen
  double adminPercentage = 0;
  Map<String, double> persons = {};
  List<String> keys = [];
  List<TextFormField> personFields = [];

  double adminProfit = 0.0;
  Map<String, double> personNetProfit = {};

  void addProfitField() {
    Key formkey = Key('${profitFields.length + 1}');
    profitList.add(0.0);
    profitFields.add(
      CustomTextFormField(
        formKey: formkey,
        labelText: 'Profit # ${profitFields.length + 1}',
        onChanged: (value) {
          // get index
          int index = 0;
          for (var i = 0; i < profitFields.length; i++) {
            if (profitFields[i].formKey == formkey) {
              index = i;
              break;
            }
          }

          profitList[index] = double.parse(value);

          if (kDebugMode) {
            print('profitList: $profitList');
          }

          emit(ValueAddedState());
        },
      ),
    );
    emit(AddFieldState());
  }

  void deleteProfitField() {
    if (profitFields.isNotEmpty) {
      profitFields.removeLast();
    }

    if (profitList.isNotEmpty) {
      totalProfit -= profitList.last;
      profitList.removeLast();
    }
    emit(DeleteProfitFieldState());
  }

  void addExpenseField() {
    Key formkey = Key('${expenseFields.length + 1}');
    expenseList.add(0.0);
    expenseFields.add(
      CustomTextFormField(
        formKey: formkey,
        labelText: 'Expense # ${expenseFields.length + 1}',
        onChanged: (value) {
          // get index
          int index = 0;
          for (var i = 0; i < expenseFields.length; i++) {
            if (expenseFields[i].formKey == formkey) {
              index = i;
              break;
            }
          }

          expenseList[index] = double.parse(value);

          if (kDebugMode) {
            print('expenseList: $expenseList');
          }
          emit(ValueAddedState());
        },
      ),
    );
    emit(AddFieldState());
  }

  void deleteExpenseField() {
    if (expenseFields.isNotEmpty) {
      expenseFields.removeLast();
    }
    if (expenseList.isNotEmpty) {
      totalExpense -= expenseList.last;
      expenseList.removeLast();
    }
    emit(DeleteExpenseFieldState());
  }

  void calculate() {
    totalProfit = 0;
    for (var profit in profitList) {
      totalProfit += profit;
    }

    totalProfit = roundDouble(totalProfit);

    totalExpense = 0;
    for (var expense in expenseList) {
      totalExpense += expense;
    }

    totalExpense = roundDouble(totalExpense);

    netProfit = totalProfit - totalExpense;
    netProfit = roundDouble(netProfit);

    adminProfit = totalProfit * (adminPercentage / 100);
    adminProfit = roundDouble(adminProfit);

    for (var key in keys) {
      personNetProfit[key] = roundDouble(netProfit * (persons[key]! / 100));
    }

    emit(CalculateState());
  }

  // settings screen
  void loadData() {
    keys = CacheController.getKeys();
    if (keys.isNotEmpty) {
      adminPercentage = CacheController.getData(key: 'admin')!.toDouble();
      keys.remove('admin');

      for (var key in keys) {
        double? value = CacheController.getData(key: key)!.toDouble();
        persons[key] = value;
      }
    } else {
      adminPercentage = 0;
      persons = {};
      CacheController.saveData(key: 'admin', value: 50.0);
    }
    emit(DataLoadedSuccessState());
  }

  void saveData() {
    CacheController.saveData(key: 'admin', value: adminPercentage);
    for (var key in keys) {
      CacheController.saveData(key: key, value: persons[key]!);
    }
    emit(DataSavedState());
  }

  void addPerson({
    required String name,
    required double percentage,
  }) async {
    keys.add(name);
    persons[name] = percentage;
    await CacheController.saveData(key: name, value: percentage);
    emit(AddPersonState());
  }

  Future<void> deletePerson({
    required String name,
    required int index,
  }) async {
    persons.remove(name);
    keys.remove(name);
    if (personFields.isNotEmpty) {
      personFields.removeAt(index);
    }
    await CacheController.removeData(key: name);
    emit(DeletePersonState());
  }

  double roundDouble(double value) {
    return double.parse(value.toStringAsFixed(4));
  }

  String getCurrentDate() {
    DateTime now = DateTime.now();
    return '${now.day}/${now.month}/${now.year}';
  }
}
