import 'package:calculator/core/cache_controller.dart';
import 'package:calculator/core/functions.dart';
import 'package:calculator/core/widgets/custom_text_form_field.dart';
import 'package:calculator/features/home/cubit/calculator_state.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CalculatorCubit extends Cubit<CalculatorState> {
  CalculatorCubit() : super(CalculatorInitial());

  static CalculatorCubit get(context) => BlocProvider.of(context);

  int kitNumbers = 0;
  String note = '';
  
  /// home screen
  double totalProfit = 0;
  List<double> profitList = [];
  // List<CustomTextFormField> profitFields = [];

  double totalExpense = 0;
  List<double> expenseList = [];
  // List<CustomTextFormField> expenseFields = [];

  double netProfit = 0;

  double adminPercentage = 0;
  List<String> keys = [];
  List<TextFormField> personFields = [];
  Map<String, double> persons = {};

  double adminProfit = 0.0;
  Map<String, double> personNetProfit = {};




  // void addField({
  //   required List<double> list,
  //   required List<CustomTextFormField> fields,
  //   required String label,
  //   required CalculatorState state,
  // }) {
  //   Key formkey = Key('${fields.length + 1}');
  //   list.add(0.0);

  //   fields.add(
  //     CustomTextFormField(
  //       formKey: formkey,
  //       labelText: '$label # ${fields.length + 1}',
  //       onChanged: (value) {
  //         int index = 0;
  //         for (int i = 0; i < fields.length; i++) {
  //           if (fields[i].formKey == formkey) {
  //             index = i;
  //             break;
  //           }
  //         }

  //         list[index] = double.parse(value);
  //         emit(state);
  //       },
  //     ),
  //   );
  //   emit(AddFieldState());
  // }

  // void addProfitField() {
  //   if (kDebugMode) {
  //     print('addProfitField');
  //   }
  //   addField(
  //     list: profitList,
  //     fields: profitFields,
  //     label: 'Profit',
  //     state: ValueAddedState(),
  //   );
  // }

  // void deleteProfitField() {
  //   if (profitFields.isNotEmpty) {
  //     profitFields.removeLast();
  //   }

  //   if (profitList.isNotEmpty) {
  //     totalProfit -= profitList.last;
  //     profitList.removeLast();
  //   }
  //   emit(DeleteProfitFieldState());
  // }

  // void addExpenseField() {
  //   addField(
  //     list: expenseList,
  //     fields: expenseFields,
  //     label: 'Expense',
  //     state: ValueAddedState(),
  //   );
  // }

  // void deleteExpenseField() {
  //   if (expenseFields.isNotEmpty) {
  //     expenseFields.removeLast();
  //   }
  //   if (expenseList.isNotEmpty) {
  //     totalExpense -= expenseList.last;
  //     expenseList.removeLast();
  //   }
  //   emit(DeleteExpenseFieldState());
  // }

  /// output screen
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

  /// settings screen
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
      adminPercentage = 50;
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

  // edit profit list 
  void addProfitItem(int number, int value) {

  }

  Future<void> deleteProfitItem(int number) async {

  }

  Future<void> clearProfitItems () async {

  }
}
