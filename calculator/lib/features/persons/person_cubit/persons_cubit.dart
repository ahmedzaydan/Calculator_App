import 'package:calculator/app/resources/constants_manager.dart';
import 'package:calculator/app/resources/strings_manager.dart';
import 'package:calculator/app/utils/cache_controller.dart';
import 'package:calculator/app/utils/extensions.dart';
import 'package:calculator/app/utils/functions.dart';
import 'package:calculator/features/app_layout/app_layout_cubit/app_states.dart';
import 'package:calculator/features/persons/models/person_model.dart';
import 'package:calculator/features/persons/person_cubit/persons_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PersonsCubit extends Cubit<AppStates> {
  PersonsCubit() : super(PersonInitialState());

  // keys
  final String personKeysKey = 'personKeys';
  final String amdinKey = 'adminPercentage';

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
      adminPercentage = CacheController.getDoubleData(amdinKey) ?? 30;

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

  Future<void> addPerson({
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
        await CacheController.saveData(
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
            }
          },
        );
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
    }
  }

  String? _validateNewPersonData(String name, double percentage) {
    // check if person name already exists
    if (CacheController.checkKey(name)) {
      return StringsManager.personExists;
    }

    return _validatePercentage(0, percentage);
  }

  String? _validatePercentage(
    double oldPercentage,
    double newPercentage,
  ) {
    // check if perecentage is valid or not
    if (newPercentage < 0 || newPercentage > 100) {
      return StringsManager.invalidPercentage;
    }

    // check if total percentage is less than 100
    if (totalPercentage - oldPercentage + newPercentage > 100) {
      return StringsManager.percentageError;
    }
    return null;
  }

  Future<bool?> updatePersonPercentage({
    required int index,
    required double value,
  }) async {
    try {
      double oldPercentage = personItems[index].percentage;
      String? errorMessage = _validatePercentage(oldPercentage, value);

      if (errorMessage == null) {
        personItems[index].setPercentage(value);

        CacheController.saveData(
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
        CacheController.saveData(amdinKey, value).then(
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
                    label: StringsManager.admin,
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
                    label: StringsManager.admin,
                  ),
                ),
              );
              return false;
            }
          },
        );
      } else {
        emit(
          UpdateAdminPercentageErrorState(
            getStateMessage(
              state: AppState.error,
              itemType: ItemType.person,
              action: ItemAction.update,
              label: StringsManager.admin,
            ),
          ),
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
            label: StringsManager.admin,
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
    try {
      // remove person from shared preferences
      await CacheController.removeData(personItems[index].name);

      // remove person from the personItems list
      personItems.removeAt(index);
      emit(
        DeletePersonSuccessState(
          getStateMessage(
            state: AppState.success,
            itemType: ItemType.person,
            action: ItemAction.delete,
          ),
        ),
      );
    } catch (e) {
      emit(
        DeletePersonErrorState(
          getStateMessage(
            state: AppState.error,
            itemType: ItemType.person,
            action: ItemAction.delete,
          ),
        ),
      );
    }
  }
}
