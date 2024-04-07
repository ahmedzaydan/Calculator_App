import 'package:calculator/app/resources/color_manager.dart';
import 'package:calculator/app/resources/strings_manager.dart';
import 'package:calculator/app/utils/cache_controller.dart';
import 'package:calculator/app/utils/extensions.dart';
import 'package:calculator/app/utils/functions.dart';
import 'package:calculator/features/persons/models/person_model.dart';
import 'package:calculator/features/persons/person_cubit/persons_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PersonsCubit extends Cubit<PersonsStates> {
  PersonsCubit() : super(PersonInitialState());

  // final ProfitCubit profitCubit;

  // keys
  final String personKeysKey = 'personKeys';
  final String amdinKey = 'adminPercentage';

  double adminPercentage = 0.0;
  double totalPercentage = 0.0;
  double adminProfit = 0.0;
  List<PersonModel> personItems = [];

  Future<void> loadData(List<String> personKeys) async {
    try {
      // load admin percentage
      adminPercentage = CacheController.getDoubleData(amdinKey).orZero;

      for (String key in personKeys) {
        List<String> personData =
            CacheController.getStringListData(key).orEmpty;

        if (personData.isNotEmpty) {
          PersonModel person = PersonModel.fromJson(personData);
          totalPercentage += person.percentage;
          personItems.add(person);
        }
      }
      emit(LoadPersonsDataSuccessState());
    } catch (e) {
      emit(LoadPersonsDataErrorState(e.toString()));
    }
  }

  void handleAdminPercentage() async {
    adminPercentage = CacheController.getDoubleData(amdinKey) ?? 30;

    await CacheController.saveData(amdinKey, adminPercentage);
  }

  Future<void> addPerson({
    required String name,
    required double percentage,
  }) async {
    try {
      emit(AddPersonLoadingState());

      String? errorMessage = _validatePersonData(name, percentage);
      if (errorMessage == null) {
        // create person object
        // DateTime startDate = DateTime.now();
        DateTime startDate = DateTime(
          2022,
          11,
          7,
        );
        int futureMonth = startDate.month + 6;
        
        int futureYear = startDate.year + 2 + (futureMonth ~/ 12);
        futureMonth %= 12;

        int futureDay = startDate.day;
        // handle future day
        DateTime endDate = DateTime(
          futureYear,
          futureMonth,
        );

        PersonModel person = PersonModel(
          name: name,
          percentage: percentage,
          startDate: startDate,
          endDate: endDate,
        );

        totalPercentage += percentage;
        personItems.add(person);

        // add person to shared preferences
        await CacheController.saveData(
          person.name,
          person.toStringList(),
        );

        emit(AddPersonSuccessState());
      } else {
        emit(AddPersonErrorState(errorMessage));
      }
    } catch (e) {
      emit(AddPersonErrorState(e.toString()));
    }
  }

  String? _validatePersonData(String name, double percentage) {
    // check if person name already exists
    if (CacheController.checkKey(name)) {
      return StringsManager.personExists;
    }

    // check if perecentage is valid or not
    if (percentage < 0 || percentage > 100) {
      return StringsManager.invalidPercentage;
    }

    // check if total percentage is less than 100
    if (totalPercentage + percentage > 100) {
      return StringsManager.percentageError;
    }
    return null;
  }

  Future<void> updatePersonPercentage({
    required int index,
    required double value,
  }) async {
    try {
      personItems[index].setPercentage(value);
      CacheController.saveData(
        personItems[index].name,
        personItems[index].toStringList(),
      );

      emit(SavePersonDataSuccessState());
    } catch (e) {
      emit(SavePersonDataErrorState(e.toString()));
    }
  }

  void calculatePersonShareValues(double totalNetProfit) {
    for (var person in personItems) {
      person.calculateShareValue(totalNetProfit);
    }
  }

  Color getPersonColor(PersonModel person) {
    DateTime now = DateTime.now();
    DateTime endDate = person.endDate;

    kprint("Person: ${person.name}");
    kprint("Start Date: ${person.startDate}");
    kprint("End Date: $endDate");
    kprint("Now: $now");
    kprint("Date difference ${endDate.month - now.month}\n\n");
    // if the remaining months are 1 month
    if (endDate.month - now.month == 1) {
      return ColorManager.red;
    } else if (endDate.month - now.month == 7 && endDate.day - now.day <= 10) {
      return ColorManager.organe;
    } else if (endDate.month - now.month == 18 && endDate.day - now.day <= 10) {
      return ColorManager.green;
    } else {
      return ColorManager.transparent;
    }
  }

  Future<void> deletePerson(int index) async {
    try {
      // remove person from shared preferences
      await CacheController.removeData(personItems[index].name);

      // remove person from the personItems list
      personItems.removeAt(index);
      emit(DeletePersonSuccessState());
    } catch (e) {
      emit(DeletePersonErrorState(e.toString()));
    }
  }
}
