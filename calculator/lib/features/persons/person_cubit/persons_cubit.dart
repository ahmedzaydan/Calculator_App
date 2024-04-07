import 'package:calculator/app/resources/strings_manager.dart';
import 'package:calculator/app/utils/cache_controller.dart';
import 'package:calculator/app/utils/extensions.dart';
import 'package:calculator/features/persons/models/person_model.dart';
import 'package:calculator/features/persons/person_cubit/persons_states.dart';
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
        int futureMonth = DateTime.now().month + 6;
        int futureYear = DateTime.now().year + 2 + (futureMonth ~/ 12);
        futureMonth %= 12;
        DateTime endDate = DateTime(
          futureYear,
          futureMonth,
          DateTime.now().day, // TODO: handle if day is 30 or 31
        );

        PersonModel person = PersonModel(
          name: name,
          percentage: percentage,
          startDate: DateTime.now(),
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
      // TODO: for all async function use .then
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
