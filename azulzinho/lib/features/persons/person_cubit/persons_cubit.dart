import 'package:azulzinho/app/resources/constants_manager.dart';
import 'package:azulzinho/app/resources/strings_manager.dart';
// import 'package:azulzinho/app/resources/strings_manager.dart';
import 'package:azulzinho/app/utils/sqflite_service.dart';
import 'package:azulzinho/app/utils/extensions.dart';
import 'package:azulzinho/app/utils/functions.dart';
import 'package:azulzinho/features/app_layout/app_layout_cubit/app_states.dart';
import 'package:azulzinho/features/persons/models/person_model.dart';
import 'package:azulzinho/features/persons/person_cubit/persons_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PersonsCubit extends Cubit<AppStates> {
  PersonsCubit() : super(PersonInitialState());

  // keys
  final String personKeysKey = 'personKeys';
  final String amdinKey = 'adminKey';

  double adminPercentage = 0.0;
  double totalPercentage = 0.0;
  double adminProfit = 0.0;
  List<PersonModel> personItems = [];

  Future<void> loadData(List<String> personKeys) async {
    try {
      emit(
        LoadPersonsDataLoadingState(
          getStateMessage(
            state: AppState.loading,
            itemType: ItemType.person,
          ),
        ),
      );

      // load admin percentage
      adminPercentage = Prefs.getDouble(amdinKey) ?? 30;
      totalPercentage = 0;

      // load persons data
      personItems.clear();

      for (String key in personKeys) {
        List<String> personData = Prefs.getStringList(key).orEmpty;

        if (personData.isNotEmpty) {
          PersonModel person = PersonModel.fromJson(personData);
          totalPercentage += person.percentage;
          personItems.add(person);
        }
      }
      emit(LoadPersonsDataSuccessState());
    } catch (e) {
      emit(
        LoadPersonsDataErrorState(
          getStateMessage(
            state: AppState.error,
            itemType: ItemType.person,
            action: ItemAction.load,
          ),
        ),
      );
    }
  }

  Future<bool?> addPerson({
    required String name,
    required double percentage,
  }) async {
    try {
      emit(AddPersonLoadingState());

      String? errorMessage = _validateNewPersonData(name, percentage);
      if (errorMessage == null) {
        // create person object
        PersonModel person = PersonModel(
          name: name,
          percentage: percentage,
        );

        // add person to shared preferences
        await Prefs.save(
          person.name,
          person.toStringList(),
        ).then(
          (result) {
            // if person is added successfully
            if (result) {
              totalPercentage += percentage;
              personItems.add(person);
              emit(
                AddPersonSuccessState(
                  getStateMessage(
                    state: AppState.success,
                    itemType: ItemType.person,
                    action: ItemAction.add,
                    label: name,
                  ),
                ),
              );

              return true;
            } else {
              emit(
                AddPersonErrorState(
                  getStateMessage(
                    state: AppState.error,
                    itemType: ItemType.person,
                    action: ItemAction.add,
                    label: name,
                  ),
                ),
              );

              return false;
            }
          },
        );
      } else {
        emit(
          AddPersonErrorState(errorMessage),
        );

        return false;
      }
    } catch (e) {
      emit(
        AddPersonErrorState(
          getStateMessage(
            state: AppState.error,
            itemType: ItemType.person,
            action: ItemAction.add,
            label: name,
          ),
        ),
      );

      return false;
    }

    return null;
  }

  String? _validateNewPersonData(String name, double percentage) {
    // check if person name already exists
    if (Prefs.checkKey(name)) {
      return PersonsStrings.personExists;
    }

    return _validatePercentage(0, percentage);
  }

  String? _validatePercentage(
    double oldPercentage,
    double newPercentage,
  ) {
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

  Future<bool?> updatePerson({
    required int index,
    required double value,
  }) async {
    try {
      double oldPercentage = personItems[index].percentage;
      String? errorMessage = _validatePercentage(oldPercentage, value);

      if (errorMessage == null) {
        personItems[index].setPercentage(value);

        Prefs.save(
          personItems[index].name,
          personItems[index].toStringList(),
        ).then(
          (response) {
            if (response) {
              totalPercentage += value - oldPercentage;
              emit(
                UpdatePersonSuccessState(
                  getStateMessage(
                    state: AppState.success,
                    itemType: ItemType.person,
                    action: ItemAction.update,
                    label: personItems[index].name,
                  ),
                ),
              );
              return true;
            } else {
              emit(
                UpdatePersonErrorState(
                  getStateMessage(
                    state: AppState.error,
                    itemType: ItemType.person,
                    action: ItemAction.update,
                    label: personItems[index].name,
                  ),
                ),
              );
              return false;
            }
          },
        );
      } else {
        emit(
          UpdatePersonErrorState(errorMessage),
        );
        return false;
      }
    } catch (e) {
      emit(
        UpdatePersonErrorState(
          getStateMessage(
            state: AppState.error,
            itemType: ItemType.person,
            action: ItemAction.update,
            label: personItems[index].name,
          ),
        ),
      );
      return false;
    }
    return null;
  }

  Future<bool?> updateAdminPercentage(double value) async {
    try {
      double oldAdminPercentage = adminPercentage;
      String? errorMessage = _validatePercentage(oldAdminPercentage, value);

      if (errorMessage == null) {
        Prefs.save(amdinKey, value).then(
          (response) {
            if (response) {
              adminPercentage = value;
              totalPercentage += value - oldAdminPercentage;

              emit(
                UpdateAdminSuccessState(
                  getStateMessage(
                    state: AppState.success,
                    itemType: ItemType.person,
                    action: ItemAction.update,
                    label: PersonsStrings.admin,
                  ),
                ),
              );
              return true;
            } else {
              emit(
                UpdateAdminPercentageErrorState(
                  getStateMessage(
                    state: AppState.error,
                    itemType: ItemType.person,
                    action: ItemAction.update,
                    label: PersonsStrings.admin,
                  ),
                ),
              );
              return false;
            }
          },
        );
      } else {
        emit(
          UpdateAdminPercentageErrorState(errorMessage),
        );
        return false;
      }
    } catch (error) {
      emit(
        UpdateAdminPercentageErrorState(
          getStateMessage(
            state: AppState.error,
            itemType: ItemType.person,
            action: ItemAction.update,
            label: PersonsStrings.admin,
          ),
        ),
      );
      return false;
    }
    return null;
  }

  void calculatePersonsShareValues(double totalNetProfit) {
    for (var person in personItems) {
      person.calculateShareValue(totalNetProfit);
    }
  }

  Future<void> deletePerson(int index) async {
    String personName = personItems[index].name;

    // remove person from shared preferences
    Prefs.remove(personName).then((deletionResult) {
      // update total percentage
      totalPercentage -= personItems[index].percentage;

      // remove person from the personItems list
      personItems.removeAt(index);

      emit(
        DeletePersonSuccessState(
          getStateMessage(
            state: AppState.success,
            itemType: ItemType.person,
            action: ItemAction.delete,
            label: personName,
          ),
        ),
      );
    }).catchError((e) {
      emit(
        DeletePersonErrorState(
          getStateMessage(
            state: AppState.error,
            itemType: ItemType.person,
            action: ItemAction.delete,
            label: personName,
          ),
        ),
      );
    });
  }
}
