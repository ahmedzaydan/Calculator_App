import 'package:calculator/app/resources/strings_manager.dart';
import 'package:calculator/app/utils/cache_controller.dart';
import 'package:calculator/app/utils/extensions.dart';
import 'package:calculator/app/utils/functions.dart';
import 'package:calculator/features/app_layout/app_layout_cubit/app_states.dart';
import 'package:calculator/features/kits/kit_cubit/kit_states.dart';
import 'package:calculator/features/kits/models/kit_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

enum KitStatus {
  transparent, // transparent
  month12, // green
  month24, // orange
  month30, // red
  expired, // gray
}

class KitsCubit extends Cubit<AppStates> {
  KitsCubit() : super(KitsInitialState());

  double totalKits = 0.0;
  String checkedKits = '';
  String kitKeyPrefix = 'Kit';

  List<KitModel> kitItems = [];

  List<KitModel> expiredKitsItems = [];
  List<KitModel> month30KitsItems = [];
  List<KitModel> month24KitsItems = [];
  List<KitModel> month12KitsItems = [];
  List<KitModel> transparentKitsItems = [];

  bool isExpiredListCollapsed = true;
  bool isMonth30ListCollapsed = true;
  bool isMonth24ListCollapsed = true;
  bool isMonth12ListCollapsed = true;
  bool isTransperantListCollapsed = true;

  Future<void> loadData(List<String> kitKeys) async {
    try {
      emit(LoadKitsDataLoadingState());
      for (String key in kitKeys) {
        List<String> kitData = CacheController.getStringListData(key).orEmpty;

        if (kitData.isNotEmpty) {
          KitModel kit = KitModel.fromStringList(kitData);
          kit.setStatus(getKitStatus(kit));
          kitItems.add(kit);
        }
      }
      emit(LoadKitsDataSuccessState());
      fillLists();
      sortKits();
    } catch (e) {
      emit(LoadKitsDataErrorState(e.toString()));
    }
  }

  Future<void> addKit({
    required String name,
    required double value,
  }) async {
    try {
      emit(AddKitLoadingState());

      String storingKey = _getStoringKey(name);

      // ensure that the key is not already stored
      if (CacheController.checkKey(storingKey) == false) {
        DateTime startDate = DateTime.now();
        DateTime endDate = _getKitEndDate(startDate);

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
              kit.setStatus(getKitStatus(kit));
              kitItems.add(kit);
              emit(AddKitSuccessState());
              fillLists();
              sortKits();
            } else {
              emit(AddKitErrorState(StringsManager.defaultError));
            }
          },
        );
      } else {
        emit(AddKitErrorState(StringsManager.kitExists));
      }
    } catch (e) {
      emit(AddKitErrorState(e.toString()));
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

  KitStatus getKitStatus(KitModel kit) {
    KitStatus status = KitStatus.transparent;

    DateTime now = DateTime.now();

    // contract is expired
    if (now.year > kit.endDate.year ||
        (now.year == kit.endDate.year && now.month > kit.endDate.month) ||
        (now.year == kit.endDate.year &&
            now.month == kit.endDate.month &&
            now.day > kit.endDate.day)) {
      status = KitStatus.expired;
    }

    // contract is in the month 30
    else if (now.year == kit.endDate.year && now.month == kit.endDate.month) {
      status = KitStatus.month30;
    }

    // contract is in the month 24
    else if (now.year - kit.startDate.year == 2 &&
        kit.startDate.month == now.month) {
      // get the last day of the current month
      int lastDay = DateTime(now.year, now.month + 1, 0).day;

      // if the contract within last 10 days of month 24
      if ((lastDay >= 30 && now.day >= 20) ||
          (lastDay < 30 && (now.day >= (lastDay - 10)))) {
        status = KitStatus.month24;
      }
      status = KitStatus.month24; // TODO: remove this line
    }

    // contract is in the month 12
    else if (now.year - kit.startDate.year == 1 &&
        now.month == kit.startDate.month) {
      // get the last day of the current month
      int lastDay = DateTime(now.year, now.month + 1, 0).day;

      // if the contract within last 10 days of month 12
      if ((lastDay >= 30 && now.day >= 20) ||
          (lastDay < 30 && (now.day >= (lastDay - 10)))) {
        status = KitStatus.month12;
      }
      status = KitStatus.month12; // TODO: remove this line
    }

    return status;
  }

  Future<bool?> updateKitValue({
    required int index,
    required double value,
  }) async {
    try {
      CacheController.saveData(
        kitItems[index].name,
        kitItems[index].toStringList(),
      ).then(
        (updateResult) {
          if (updateResult) {
            kitItems[index].setValue(value);

            emit(UpdateKitDataSuccessState());
            sortKits();
            fillLists();

            return true;
          } else {
            emit(UpdateKitDataErrorState(StringsManager.defaultError));
            return false;
          }
        },
      );
    } catch (e) {
      emit(UpdateKitDataErrorState(e.toString()));
      return false;
    }
    return null;
  }

  Future<void> changeKitStatus(int index) async {
    try {
      kitItems[index].toggleStatus();
      await CacheController.saveData(
        kitItems[index].name,
        kitItems[index].toStringList(),
      );

      emit(KitStatusChangedSuccessState());
    } catch (e) {
      emit(KitStatusChangedErrorState(e.toString()));
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

  void fillLists() {
    for (var kit in kitItems) {
      switch (kit.status) {
        case KitStatus.expired:
          expiredKitsItems.add(kit);
          break;
        case KitStatus.month12:
          month12KitsItems.add(kit);
          break;
        case KitStatus.month24:
          month24KitsItems.add(kit);
          break;
        case KitStatus.month30:
          month30KitsItems.add(kit);
          break;
        case KitStatus.transparent:
          transparentKitsItems.add(kit);
          break;
        default:
          break;
      }
    }
  }

  void sortKits() {
    kitItems.sort(
      (a, b) {
        int aIndex = int.parse(a.name.substring(kitKeyPrefix.length));
        int bIndex = int.parse(b.name.substring(kitKeyPrefix.length));
        return aIndex.compareTo(bIndex);
      },
    );
    emit(KitsSortedState());
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

    totalKits = roundDouble(totalKits);
  }

  void toggleExpiredListVisibility() {
    isExpiredListCollapsed = !isExpiredListCollapsed;
    emit(ToggleKitListVisibilityState());
  }

  void toggleMonth30ListVisibility() {
    isMonth30ListCollapsed = !isMonth30ListCollapsed;
    emit(ToggleKitListVisibilityState());
  }

  void toggleMonth24ListVisibility() {
    isMonth24ListCollapsed = !isMonth24ListCollapsed;
    emit(ToggleKitListVisibilityState());
  }

  void toggleMonth12ListVisibility() {
    isMonth12ListCollapsed = !isMonth12ListCollapsed;
    emit(ToggleKitListVisibilityState());
  }

  void toggleTransparentListVisibility() {
    isTransperantListCollapsed = !isTransperantListCollapsed;
    emit(ToggleKitListVisibilityState());
  }

  Future<void> deleteKitItem(int index) async {
    try {
      CacheController.removeData(kitItems[index].name).then((result) {
        if (result) {
          emit(DeleteKitSuccessState());
          kitItems.removeAt(index);
          sortKits();
          fillLists();
        } else {
          emit(DeleteKitErrorState(StringsManager.defaultError));
        }
      });

      emit(DeleteKitSuccessState());
    } catch (e) {
      emit(DeleteKitErrorState(e.toString()));
    }
  }
}

// TODO: remove these lines
// // Contract expired
// DateTime date1 = DateTime(2020, 10, 9);
// // Contract in the month 30
// DateTime date2 = DateTime(2021, 10, 9);
// // Contract in the month 24 (within last 10 days of month 24)
// DateTime date3 = DateTime(2022, 4, 8);
// // Contract in the month 12 (within last 10 days of month 12)
// DateTime date4 = DateTime(2023, 4, 8);