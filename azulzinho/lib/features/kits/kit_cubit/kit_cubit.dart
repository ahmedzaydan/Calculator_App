import 'package:azulzinho/app/resources/strings_manager.dart';
import 'package:azulzinho/app/utils/functions.dart';
import 'package:azulzinho/app/utils/sqflite_service.dart';
import 'package:azulzinho/features/app_layout/app_layout_cubit/app_states.dart';
import 'package:azulzinho/features/kits/kit_cubit/kit_states.dart';
import 'package:azulzinho/features/kits/models/kit_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class KitsCubit extends Cubit<AppStates> {
  KitsCubit() : super(KitsInitialState());

  // keys
  String kitKeyPrefix = 'Kit';
  String expiredKitKeyPrefix = 'ek';
  String expiredKitsCounterKey = 'ekc';

  double totalKits = 0.0;
  String checkedKits = '';
  DateTime selectedDate = DateTime.now();

  List<bool> collapsedLists = [
    true,
    true,
    true,
    true,
    true,
  ];

  List<String> listsTitles = [
    KitsStrings.normal,
    KitsStrings.month12,
    KitsStrings.month24,
    KitsStrings.month30,
    KitsStrings.expired,
  ];

  List<KitModel> kits = [];
  List<KitModel> expiredKits = [];
  List<KitModel> month30Kits = [];
  List<KitModel> month24Kits = [];
  List<KitModel> month12Kits = [];
  List<KitModel> normalKits = [];

  /// Methods deals with storage
  Future<void> fetchData() async {
    try {
      emit(FetchKitsDataLoadingState());

      // get all records from database
      var records = await SqfliteService.getRecords(
        KitsStrings.tableName,
      );

      // clear the lists
      kits.clear();
      clearLists();

      kprint('Records: $records');

      // extract the data from the records
      for (var kitRecord in records) {
        KitModel kitModel = KitModel.fromMap(kitRecord);

        kitModel.selectStatus();

        addKitToList(kitModel, sort: false);
      }

      emit(FetchKitsSuccessState());

      sortKits();
    } catch (error) {
      kprint('From Load Kits function, error:\n${error.toString()}');
      emit(FetchKitsErrorState());
    }
  }

  Future<bool> createKit({
    required String name,
    required double value,
  }) async {
    try {
      emit(CreateKitLoadingState());

      // check if the kit name is not already exist
      var rows = await SqfliteService.getMatchedRecords(
        tableName: KitsStrings.tableName,
        condition: "name = $name",
      );

      // if kit name already exists
      if (rows.isNotEmpty) {
        emit(CreateKitErrorState(KitsStrings.kitExists));
        return false;
      }

      // if kit name is not exists
      else {
        // create kit object
        KitModel kit = KitModel(
          name: name,
          value: value,
          startDate: getFormattedDate(date: selectedDate),
        );

        kprint('KitEndDate: ${kit.endDate}');

        int kitId = await SqfliteService.insertRow(
          '''INSERT INTO ${KitsStrings.tableName}
          (name, value, isChecked, isExpired, startDate, endDate)
          VALUES (
            '${kit.name}',
            '${kit.value}',
            '${kit.isChecked ? 1 : 0}',
            '${kit.isExpired ? 1 : 0}',
            '${kit.startDate}',
            '${kit.endDate}'
            )''',
        );

        // if kit is not inserted successfully
        if (kitId == -1) {
          emit(CreateKitErrorState(name));

          return false;
        }

        // if kit is inserted successfully
        else {
          kit.setDbId(kitId);
          addKitToList(kit);
          emit(CreateKitSuccessState(name));
          return true;
        }
      }
    } catch (e) {
      emit(CreateKitErrorState(name));

      return false;
    }
  }

  Future<bool> updateKit({
    required KitModel kitModel,
    required double value,
  }) async {
    bool isUpdated = false;
    try {
      kitModel.setValue(value);

      isUpdated = await SqfliteService.updateRecord(
        tableName: KitsStrings.tableName,
        data: '''value = ${kitModel.value}''',
        id: kitModel.getDbId,
      );

      if (isUpdated) {
        emit(UpdateKitSuccessState(kitModel.name));
        updateKitInList(kitModel);
        return isUpdated;
      } else {
        emit(UpdateKitErrorState(kitModel.name));
        return isUpdated;
      }
    } catch (error) {
      emit(UpdateKitErrorState(kitModel.name));
      return isUpdated;
    }
  }

  Future<void> toggleKitChecked(KitModel kitModel) async {
    try {
      kitModel.toggleIsChecked();

      bool isUpdated = await SqfliteService.updateRecord(
        tableName: KitsStrings.tableName,
        data: '''isChecked = ${kitModel.isChecked ? 1 : 0}''',
        id: kitModel.getDbId,
      );

      if (isUpdated) {
        updateKitInList(kitModel);
        emit(ToggleKitCheckedStatusSuccessState());
      } else {
        emit(ToggleKitCheckedStatusErrorState(
          StringsManager.defaultError,
        ));
      }
    } catch (e) {
      kprint('Error in toggleKitChecked: $e');
      emit(ToggleKitCheckedStatusErrorState(
        StringsManager.defaultError,
      ));
    }
  }

  Future<void> clearCheckedKits() async {
    bool isCleared = true;

    for (KitModel kit in kits) {
      try {
        kit.setIsChecked(false);

        isCleared = await SqfliteService.updateRecord(
          tableName: KitsStrings.tableName,
          data: '''isChecked = 0''',
          id: kit.getDbId,
        );
      } catch (error) {
        kprint('Error in clearCheckedKits with item ${kit.name}: $error');
      }
    }

    if (isCleared) {
      emit(ClearKitItemsSuccessState());
    } else {
      emit(ClearKitItemsErrorState(StringsManager.defaultError));
    }
  }

  Future<void> deleteKit(KitModel kit) async {
    try {
      bool isDeleted = await SqfliteService.deleteRecord(
        tableName: KitsStrings.tableName,
        id: kit.getDbId,
      );

      if (isDeleted) {
        emit(DeleteKitSuccessState(kit.name));
        deleteKitFromList(kit);
      } else {
        emit(DeleteKitErrorState(kit.name));
      }
    } catch (error) {
      emit(DeleteKitErrorState(kit.name));
    }
  }

  /// Helper methods
  void addKitToList(KitModel kitModel, {bool sort = true}) {
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
        normalKits.add(kitModel);
        break;
    }

    if (kitModel.status != KitStatus.expired) {
      kits.add(kitModel);
    }

    if (sort) {
      sortKits();
    }
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
        normalKits[normalKits.indexWhere((ele) => ele.name == kit.name)] = kit;
        break;
    }

    if (kit.status != KitStatus.expired) {
      kits[kits.indexWhere((ele) => ele.name == kit.name)] = kit;
    }
  }

  void sortKits() {
    kits.sort(
      (a, b) {
        int aIndex = int.parse(a.name);
        int bIndex = int.parse(b.name);
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
        normalKits.remove(kitModel);
        break;
    }

    kits.remove(kitModel);
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
      checkedKits = checkedKits.substring(
        0,
        checkedKits.length - 3,
      );
    }

    totalKits = formatDobule(totalKits);
  }

  List<KitModel> getCollapsableList(int index) {
    switch (index) {
      case 0:
        return normalKits;
      case 1:
        return month12Kits;
      case 2:
        return month24Kits;
      case 3:
        return month30Kits;
      default:
        return expiredKits;
    }
  }

  void clearLists() {
    expiredKits.clear();
    month30Kits.clear();
    month24Kits.clear();
    month12Kits.clear();
    normalKits.clear();
  }
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
