import 'package:calculator/app/resources/constants_manager.dart';
import 'package:calculator/app/resources/strings_manager.dart';
import 'package:calculator/app/utils/cache_controller.dart';
import 'package:calculator/app/utils/extensions.dart';
import 'package:calculator/app/utils/functions.dart';
import 'package:calculator/features/app_layout/app_layout_cubit/app_states.dart';
import 'package:calculator/features/kits/kit_cubit/kit_states.dart';
import 'package:calculator/features/kits/models/kit_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class KitsCubit extends Cubit<AppStates> {
  KitsCubit() : super(KitsInitialState());

  double totalKits = 0.0;
  String checkedKits = '';
  String kitKeyPrefix = 'Kit';

  List<bool> collapsedLists = [true, true, true, true, true];

  List<String> listsTitles = [
    KitsStrings.expired,
    KitsStrings.month30,
    KitsStrings.month24,
    KitsStrings.month12,
    KitsStrings.normal,
  ];

  List<KitModel> kits = [];
  List<KitModel> expiredKits = [];
  List<KitModel> month30Kits = [];
  List<KitModel> month24Kits = [];
  List<KitModel> month12Kits = [];
  List<KitModel> transparentKits = [];

  Future<void> loadData(List<String> kitKeys) async {
    try {
      emit(
        LoadKitsDataLoadingState(
          getStateMessage(
            state: AppState.loading,
            itemType: ItemType.kit,
          ),
        ),
      );

      kits.clear();
      clearLists();

      for (String key in kitKeys) {
        List<String> kitData = CacheController.getStringListData(key).orEmpty;

        if (kitData.isNotEmpty) {
          KitModel kit = KitModel.fromStringList(kitData);
          kit.selectStatus();
          addKitToCorrectList(kit);
        }
      }

      emit(LoadKitsDataSuccessState());
    } catch (e) {
      emit(
        LoadKitsDataErrorState(
          getStateMessage(
            state: AppState.error,
            itemType: ItemType.kit,
            action: ItemAction.load,
          ),
        ),
      );
    }
  }

  Future<void> addKit({
    required String name,
    required double value,
  }) async {
    emit(AddKitLoadingState());

    String storingKey = _getStoringKey(name);

    // ensure that the key is not already stored
    if (CacheController.checkKey(storingKey) == false) {
      // DateTime startDate = getCurrentDate();

      // TODO: remove these lines
      List<DateTime> temp = [
        DateTime(2020, 10, 9), // expired
        DateTime(2021, 10, 11), // month30
        DateTime(2022, 4, 8), // month24
        DateTime(2023, 4, 8), // month12
        DateTime(2023, 10, 8), // transparent
      ];

      DateTime startDate = temp[1];

      // create kit object
      KitModel kit = KitModel(
        name: storingKey,
        value: value,
        startDate: startDate,
      );

      // add kit to shared preferences
      CacheController.saveData(
        kit.name,
        kit.toStringList(),
      ).then((saveResult) {
        if (saveResult) {
          addKitToCorrectList(kit);

          emit(
            AddKitSuccessState(
              getStateMessage(
                state: AppState.success,
                itemType: ItemType.kit,
                action: ItemAction.add,
                label: kit.name,
              ),
            ),
          );
        } else {
          emit(
            AddKitErrorState(
              getStateMessage(
                state: AppState.error,
                itemType: ItemType.kit,
                action: ItemAction.add,
                label: name,
              ),
            ),
          );
        }
      }).catchError(
        (e) {
          emit(
            AddKitErrorState(
              getStateMessage(
                state: AppState.error,
                itemType: ItemType.kit,
                action: ItemAction.add,
                label: name,
              ),
            ),
          );
        },
      );
    } else {
      emit(
        AddKitErrorState(
          getStateMessage(
            state: AppState.error,
            itemType: ItemType.kit,
            action: ItemAction.add,
            label: name,
            error: KitsStrings.kitExists,
          ),
        ),
      );
    }
  }

  void addKitToCorrectList(KitModel kitModel) {
    switch (kitModel.status!) {
      case KitStatus.expired:
        expiredKits.add(kitModel);
        break;
      case KitStatus.month30:
        month30Kits.add(kitModel);
        break;
      case KitStatus.month24:
        month24Kits.add(kitModel);
        break;
      case KitStatus.month12:
        month12Kits.add(kitModel);
        break;
      case KitStatus.normal:
        transparentKits.add(kitModel);
        break;
    }

    if (kitModel.status! != KitStatus.expired) {
      kits.add(kitModel);
      sortKits();
    }
  }

  Future<bool?> updateKit({
    required KitModel kitModel,
    required double value,
  }) async {
    kitModel.setValue(value);

    CacheController.saveData(
      kitModel.name,
      kitModel.toStringList(),
    ).then((updateResult) {
      if (updateResult) {
        emit(
          UpdateKitSuccessState(
            getStateMessage(
              state: AppState.success,
              itemType: ItemType.kit,
              action: ItemAction.update,
              label: kitModel.name,
            ),
          ),
        );

        updateKitInList(kitModel);
        return true;
      } else {
        emit(
          UpdateKitErrorState(
            getStateMessage(
              state: AppState.error,
              itemType: ItemType.kit,
              action: ItemAction.update,
              label: kitModel.name,
            ),
          ),
        );
        return false;
      }
    }).catchError(
      (e) {
        emit(
          UpdateKitErrorState(
            getStateMessage(
              state: AppState.error,
              itemType: ItemType.kit,
              action: ItemAction.update,
              label: kitModel.name,
            ),
          ),
        );
        return false;
      },
    );

    return null;
  }

  void updateKitInList(KitModel kit) {
    switch (kit.status!) {
      case KitStatus.expired:
        expiredKits[expiredKits.indexWhere((ele) => ele.name == kit.name)] =
            kit;
        break;
      case KitStatus.month30:
        month30Kits[month30Kits.indexWhere((ele) => ele.name == kit.name)] =
            kit;
        break;
      case KitStatus.month24:
        month24Kits[month24Kits.indexWhere((ele) => ele.name == kit.name)] =
            kit;
        break;
      case KitStatus.month12:
        month12Kits[month12Kits.indexWhere((ele) => ele.name == kit.name)] =
            kit;
        break;
      case KitStatus.normal:
        transparentKits[
            transparentKits.indexWhere((ele) => ele.name == kit.name)] = kit;
        break;
    }

    if (kit.status != KitStatus.expired) {
      kits[kits.indexWhere((ele) => ele.name == kit.name)] = kit;
    }
  }

  Future<void> toggleKitIsChecked(KitModel kitModel) async {
    try {
      kitModel.toggleIsChecked();

      CacheController.saveData(
        kitModel.name,
        kitModel.toStringList(),
      ).then(
        (result) {
          if (result) {
            updateKitInList(kitModel);

            emit(KitCheckedStatusChangedSuccessState());
          } else {
            emit(
              KitCheckedStatusChangedErrorState(StringsManager.defaultError),
            );
          }
        },
      );
    } catch (e) {
      emit(KitCheckedStatusChangedErrorState(e.toString()));
    }
  }

  Future<void> clearCheckedKits() async {
    for (KitModel kit in kits) {
      kit.setIsChecked(false);

      CacheController.saveData(
        kit.name,
        kit.toStringList(),
      ).then((saveResult) {
        if (saveResult) {
          emit(ClearKitItemsSuccessState());
        } else {
          emit(ClearKitItemsErrorState(StringsManager.defaultError));
        }
      }).catchError((e) {
        emit(ClearKitItemsErrorState(e.toString()));
      });
    }
  }

  void sortKits() {
    kits.sort(
      (a, b) {
        int aIndex = int.parse(a.name.substring(kitKeyPrefix.length));
        int bIndex = int.parse(b.name.substring(kitKeyPrefix.length));
        return aIndex.compareTo(bIndex);
      },
    );

    emit(KitsSortedState());
  }

  void toggleListVisibility(int index) {
    collapsedLists[index] = !collapsedLists[index];
    emit(ToggleKitListVisibilityState());
  }

  void deleteKitFromList(KitModel kitModel) {
    switch (kitModel.status!) {
      case KitStatus.expired:
        expiredKits.remove(kitModel);
        break;
      case KitStatus.month30:
        month30Kits.remove(kitModel);
        break;
      case KitStatus.month24:
        month24Kits.remove(kitModel);
        break;
      case KitStatus.month12:
        month12Kits.remove(kitModel);
        break;
      default:
        transparentKits.remove(kitModel);
        break;
    }

    kits.remove(kitModel);
  }

  Future<void> deleteKit(KitModel kit) async {
    CacheController.removeData(kit.name).then(
      (result) {
        if (result) {
          emit(
            DeleteKitSuccessState(
              getStateMessage(
                state: AppState.success,
                itemType: ItemType.kit,
                action: ItemAction.delete,
                label: kit.name,
              ),
            ),
          );

          deleteKitFromList(kit);
        } else {
          emit(
            DeleteKitErrorState(
              getStateMessage(
                state: AppState.error,
                itemType: ItemType.kit,
                action: ItemAction.delete,
                label: kit.name,
              ),
            ),
          );
        }
      },
    ).catchError(
      (e) {
        emit(
          DeleteKitErrorState(
            getStateMessage(
              state: AppState.error,
              itemType: ItemType.kit,
              action: ItemAction.delete,
              label: kit.name,
            ),
          ),
        );
      },
    );
  }

  void calculateKits() {
    totalKits = 0;
    checkedKits = '';

    for (var kit in kits) {
      if (kit.isChecked) {
        totalKits += kit.value;
        checkedKits += kit.format;
      }
    }

    if (checkedKits.isNotEmpty) {
      checkedKits = checkedKits.substring(0, checkedKits.length - 3);
    }

    totalKits = formatDobule(totalKits);
  }

  List<KitModel> getCollapsableList(int index) {
    switch (index) {
      case 0:
        return expiredKits;
      case 1:
        return month30Kits;
      case 2:
        return month24Kits;
      case 3:
        return month12Kits;
      default:
        return transparentKits;
    }
  }

  /// utility functions
  void clearLists() {
    expiredKits.clear();
    month30Kits.clear();
    month24Kits.clear();
    month12Kits.clear();
    transparentKits.clear();
  }

  String _getStoringKey(String id) => '$kitKeyPrefix$id';
}

enum KitStatus {
  expired,
  month12,
  month24,
  month30,
  normal,
}

enum SortingType {
  name,
  kitStatus,
}
