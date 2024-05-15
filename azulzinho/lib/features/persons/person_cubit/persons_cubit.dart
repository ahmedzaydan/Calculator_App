import 'package:azulzinho/core/resources/strings_manager.dart';
import 'package:azulzinho/core/utils/functions.dart';
import 'package:azulzinho/core/utils/sqflite_service.dart';
import 'package:azulzinho/features/app_layout/app_layout_cubit/app_states.dart';
import 'package:azulzinho/features/persons/models/person_model.dart';
import 'package:azulzinho/features/persons/person_cubit/persons_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PersonsCubit extends Cubit<AppStates> {
  PersonsCubit() : super(PersonInitialState());

  double totalPercentage = 0.0;

  PersonModel admin = PersonModel(
    name: PersonsStrings.admin,
    percentage: 30,
  );

  List<PersonModel> personItems = [];

  /// Methods deals with storage
  Future<void> fetchData() async {
    try {
      emit(FetchPersonsLoadingState());

      personItems.clear();
      totalPercentage = 0;

      var records = await SqfliteService.getRecords(
        PersonsStrings.tableName,
      );

      for (var record in records) {
        PersonModel person = PersonModel.fromMap(record);

        if (person.name == PersonsStrings.admin) {
          admin.percentage = person.percentage;
        } else {
          totalPercentage += person.percentage;
          personItems.add(person);
        }
      }

      emit(FetchPersonsSuccessState());
    } catch (e) {
      emit(FetchPersonsErrorState());
    }
  }

  Future<bool> createPerson({
    required String name,
    required double percentage,
  }) async {
    try {
      emit(CreatePersonLoadingState());

      String? errorMessage = await _validateData(name, percentage);

      if (errorMessage == null) {
        // create person object
        PersonModel person = PersonModel(
          name: name,
          percentage: percentage,
        );

        int id = await SqfliteService.insertRow(
          '''INSERT INTO ${PersonsStrings.tableName} 
          (name, percentage)
          VALUES (
            '${person.name}',
            '${person.percentage}')''',
        );

        if (id == -1) {
          emit(CreatePersonErrorState(person.name));
          return false;
        } else {
          person.setDbId(id);
          totalPercentage += percentage;
          personItems.add(person);
          emit(CreatePersonSuccessState(person.name));
          return true;
        }
      } else {
        emit(CreatePersonErrorState(errorMessage));
        return false;
      }
    } catch (e) {
      emit(CreatePersonErrorState(name));
      return false;
    }
  }

  Future<bool> updatePerson({
    required int index,
    required double value,
  }) async {
    bool isUpdated = false;

    try {
      double oldPercentage = personItems[index].percentage;

      String? errorMessage = validatePercentage(
        oldPercentage: oldPercentage,
        newPercentage: value,
      );

      if (errorMessage == null) {
        personItems[index].setPercentage(value);

        isUpdated = await SqfliteService.updateRecord(
          tableName: PersonsStrings.tableName,
          data: '''percentage = ${personItems[index].percentage}''',
          id: personItems[index].getDbId,
        );

        if (isUpdated) {
          totalPercentage += value - oldPercentage;
          emit(UpdatePersonSuccessState(personItems[index].name));
          return isUpdated;
        } else {
          emit(UpdatePersonErrorState(personItems[index].name));
          return isUpdated;
        }
      } else {
        emit(UpdatePersonErrorState(errorMessage));
        return isUpdated;
      }
    } catch (e) {
      emit(UpdatePersonErrorState(personItems[index].name));
      return isUpdated;
    }
  }

  Future<bool> updateAdminPercentage(double value) async {
    bool isUpdated = false;

    try {
      if (value < 0 || value > 100) {
        emit(UpdatePersonErrorState(
          PersonsStrings.admin,
          error: PersonsStrings.invalidPercentage,
        ));
        return isUpdated;
      }

      isUpdated = await SqfliteService.updateRecord(
        tableName: PersonsStrings.tableName,
        data: '''percentage = $value''',
        id: 1,
      );

      if (isUpdated) {
        totalPercentage += value - admin.percentage;
        admin.percentage = value;
        emit(UpdatePersonSuccessState(PersonsStrings.admin));
        return isUpdated;
      } else {
        emit(UpdatePersonErrorState(PersonsStrings.admin));
        return isUpdated;
      }
    } catch (error) {
      emit(
        UpdatePersonErrorState(
          PersonsStrings.admin,
          error: error.toString(),
        ),
      );
      return isUpdated;
    }
  }

  Future<void> deletePerson(int index) async {
    try {
      String personName = personItems[index].name;

      bool isDeleted = await SqfliteService.deleteRecord(
        tableName: PersonsStrings.tableName,
        id: personItems[index].getDbId,
      );

      if (isDeleted) {
        // update total percentage
        totalPercentage -= personItems[index].percentage;
        // remove person from the personItems list
        personItems.removeAt(index);
        emit(DeletePersonSuccessState(personName));
      } else {
        emit(DeletePersonErrorState(personName));
      }
    } catch (error) {
      kprint('Error in deletePerson: $error');
      emit(DeletePersonErrorState(personItems[index].name));
    }
  }

  /// Helper methods
  Future<String?> _validateData(String name, double percentage) async {
    try {
      // check if person name already exists
      var rows = await SqfliteService.getMatchedRecords(
        tableName: PersonsStrings.tableName,
        condition: "name = '$name'",
      );

      if (rows.isNotEmpty) {
        return PersonsStrings.personExists;
      }

      return validatePercentage(
        oldPercentage: 0,
        newPercentage: percentage,
      );
    } catch (error) {
      kprint('Error in _validateData: $error');
    }
    return null;
  }

  String? validatePercentage({
    required double oldPercentage,
    required double newPercentage,
  }) {
    // check if perecentage is valid or not
    if (newPercentage < 0 || newPercentage > 100) {
      return PersonsStrings.invalidPercentage;
    }

    // check if total percentage is less than 100
    if (totalPercentage - oldPercentage + newPercentage > 100) {
      return PersonsStrings.percentageError;
    }
    return null;
  }

  void calculatePersonsShareValues(double totalNetProfit) {
    for (var person in personItems) {
      person.calculateShareValue(totalNetProfit);
    }
  }
}
