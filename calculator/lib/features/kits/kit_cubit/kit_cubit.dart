import 'package:calculator/app/resources/strings_manager.dart';
import 'package:calculator/app/utils/cache_controller.dart';
import 'package:calculator/app/utils/extensions.dart';
import 'package:calculator/app/utils/functions.dart';
import 'package:calculator/features/app_layout/app_layout_cubit/app_states.dart';
import 'package:calculator/features/kits/kit_cubit/kit_states.dart';
import 'package:calculator/features/kits/models/kit_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

enum KitStatus {
  expired,
  transparent,
  month12,
  month24,
  month30,
}

enum SortingType {
  name,
  kitStatus,
}

class KitsCubit extends Cubit<AppStates> {
  KitsCubit() : super(KitsInitialState());

  double totalKits = 0.0;
  String checkedKits = '';
  String kitKeyPrefix = 'Kit';

  List<KitModel> kitItems = [];

  List<bool> collapsedLists = [
    false,
    false,
    false,
    false,
    false,
  ];

  List<String> listsTitles = [
    StringsManager.expired,
    StringsManager.month30,
    StringsManager.month24,
    StringsManager.month12,
    StringsManager.pickMeAColour, // TODO: change to better name please
  ];

  Future<void> loadData(List<String> kitKeys) async {
    try {
      emit(LoadKitsDataLoadingState());

      kitItems.clear();

      for (String key in kitKeys) {
        List<String> kitData = CacheController.getStringListData(key).orEmpty;

        if (kitData.isNotEmpty) {
          KitModel kit = KitModel.fromStringList(kitData);
          kit.selectStatus();
          kitItems.add(kit);
        }
      }

      emit(LoadKitsDataSuccessState());

      sortKits();
    } catch (e) {
      emit(LoadKitsDataErrorState(e.toString()));
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
      // DateTime startDate = DateTime.now();

      // TODO: remove these lines
      List<DateTime> temp = [
        DateTime(2020, 10, 9), // expired
        DateTime(2021, 10, 10), // month30
        DateTime(2022, 4, 8), // month24
        DateTime(2023, 4, 8), // month12
        DateTime(2023, 10, 8), // transparent
      ];

      DateTime startDate = temp[3];
      DateTime endDate = _getKitEndDate(startDate);

      kprint("End Date: $endDate");

      // create kit object
      KitModel kit = KitModel(
        name: storingKey,
        value: value,
        startDate: startDate,
        endDate: endDate,
      );

      // add kit to shared preferences
      CacheController.saveData(
        kit.name,
        kit.toStringList(),
      ).then(
        (saveResult) {
          if (saveResult) {
            // add kit to the kitItems list
            kitItems.add(kit);

            emit(AddKitSuccessState('Kit $name added successfully'));

            sortKits();
          } else {
            emit(AddKitErrorState(StringsManager.defaultError));
          }
        },
      ).catchError(
        (e) {
          emit(AddKitErrorState(e.toString()));
        },
      );
    } else {
      emit(AddKitErrorState(StringsManager.kitExists));
    }
  }

  String _getStoringKey(String id) => '$kitKeyPrefix$id';

  DateTime _getKitEndDate(DateTime startDate) {
    int futureMonth = startDate.month + 6;

    // contract duration is 2 years and 6 months
    int futureYear = startDate.year + 2;

    // if the future month is greater than 12
    // then the future year will be the next year
    futureYear += (futureMonth ~/ 12);

    // if the future month is greater than 12
    futureMonth %= 12;

    int futureDay = startDate.day - 1;

    // if future day = 0
    if (futureDay == 0) {
      // future day will be the last day of the previous month
      futureDay = DateTime(futureYear, futureMonth, 0).day;

      // future month will be the previous month
      futureMonth -= 1;

      // if the future month is January
      if (futureMonth == 0) {
        // future month will be December
        futureMonth = 12;

        // future year will be the previous year
        futureYear -= 1;
      }
    }

    // if the future day is greater than the last day of the future month
    else if (futureDay > DateTime(futureYear, futureMonth + 1, 0).day) {
      // then the future day will be the last day of future the month
      futureDay = DateTime(futureYear, futureMonth + 1, 0).day;
    }

    return DateTime(futureYear, futureMonth, futureDay);
  }

  Future<bool?> updateKitValue({
    required int index,
    required double value,
  }) async {
    CacheController.saveData(
      kitItems[index].name,
      kitItems[index].toStringList(),
    ).then(
      (updateResult) {
        if (updateResult) {
          kitItems[index].setValue(value);

          emit(UpdateKitSuccessState());
          return true;
        } else {
          emit(UpdateKitErrorState(StringsManager.defaultError));
          return false;
        }
      },
    ).catchError(
      (e) {
        emit(UpdateKitErrorState(e.toString()));
        return false;
      },
    );

    return null;
  }

  Future<void> toggleKitIsChecked(int index) async {
    try {
      kitItems[index].toggleStatus();
      await CacheController.saveData(
        kitItems[index].name,
        kitItems[index].toStringList(),
      );

      emit(KitCheckedStatusChangedSuccessState());
    } catch (e) {
      emit(KitCheckedStatusChangedErrorState(e.toString()));
    }
  }

  Future<void> clearKits() async {
    try {
      for (KitModel kit in kitItems) {
        kit.setIsChecked(false);

        await CacheController.saveData(
          kit.name,
          kit.toStringList(),
        );

        emit(ClearKitItemsSuccessState());
      }
    } catch (e) {
      emit(ClearKitItemsErrorState(e.toString()));
    }
  }

  void sortKits({
    SortingType sortingType = SortingType.kitStatus,
  }) {
    switch (sortingType) {
      case SortingType.name:
        kitItems.sort(
          (a, b) {
            int aIndex = int.parse(a.name.substring(kitKeyPrefix.length));
            int bIndex = int.parse(b.name.substring(kitKeyPrefix.length));
            return aIndex.compareTo(bIndex);
          },
        );
        break;
      case SortingType.kitStatus:
        kitItems.sort(
          (a, b) {
            return a.status!.numericValue.compareTo(
              b.status!.numericValue,
            );
          },
        );
        break;
    }

    emit(KitsSortedState());
  }

  void toggleListVisibility(int index) {
    collapsedLists[index] = !collapsedLists[index];
    emit(ToggleKitListVisibilityState());
  }

  Future<void> deleteKitItem(int index) async {
    try {
      CacheController.removeData(kitItems[index].name).then((result) {
        if (result) {
          emit(DeleteKitSuccessState());
          kitItems.removeAt(index);
        } else {
          emit(DeleteKitErrorState(StringsManager.defaultError));
        }
      });

      emit(DeleteKitSuccessState());
    } catch (e) {
      emit(DeleteKitErrorState(e.toString()));
    }
  }

  void calculateKits() {
    totalKits = 0;
    checkedKits = '';

    for (var kit in kitItems) {
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
    List<KitModel> list = [];
    switch (index) {
      case 0:
        for (var kit in kitItems) {
          if (kit.status == KitStatus.expired) {
            list.add(kit);
          }
        }
        break;
      case 1:
        for (var kit in kitItems) {
          if (kit.status == KitStatus.month30) {
            list.add(kit);
          }
        }
        break;
      case 2:
        for (var kit in kitItems) {
          if (kit.status == KitStatus.month24) {
            list.add(kit);
          }
        }
        break;
      case 3:
        for (var kit in kitItems) {
          if (kit.status == KitStatus.month12) {
            list.add(kit);
          }
        }
        break;
      default:
        for (var kit in kitItems) {
          if (kit.status == KitStatus.transparent) {
            list.add(kit);
          }
        }
        break;
    }

    return list;
  }
}
