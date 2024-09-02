import 'package:azulzinho/themes/strings_manager.dart';
import 'package:azulzinho/core/utils/functions.dart';
import 'package:azulzinho/core/utils/sqflite_service.dart';
import 'package:azulzinho/features/app_layout/app_layout_cubit/app_states.dart';
import 'package:azulzinho/features/kits/kit_cubit/kit_states.dart';
import 'package:azulzinho/features/kits/models/kit_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// TODO: try to separate it into more than one cubit please
class KitsCubit extends Cubit<AppStates> {
  double totalKits = 0.0;
  String checkedKits = '';
  DateTime? startDate;
  DateTime? endDate;

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

  KitsCubit() : super(KitsInitialState());

  static KitsCubit of(context) => BlocProvider.of<KitsCubit>(context);

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

  Future<void> createKit({
    required String name,
    required double value,
  }) async {
    String newName = '${KitsStrings.kit} $name';
    try {
      emit(CreateKitLoadingState());

      // check if the kit name is not already exist
      var rows = await SqfliteService.getMatchedRecords(
        tableName: KitsStrings.tableName,
        condition: "name = '$newName'",
      );

      // if kit name already exists
      if (rows.isNotEmpty) {
        emit(CreateKitErrorState(KitsStrings.kitExists));
      }

      // if kit name is not exists
      else {
        // create kit object
        KitModel kit = KitModel(
          name: newName,
          value: value,
          startDate: getFormattedDate(date: startDate),
          endDate: endDate != null ? getFormattedDate(date: endDate!) : null,
        );

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
          emit(CreateKitErrorState(newName));
        }

        // if kit is inserted successfully
        else {
          kit.setDbId(kitId);
          emit(CreateKitSuccessState(newName));
          addKitToList(kit);
        }
      }
    } catch (e) {
      emit(CreateKitErrorState(newName));
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

  Future<void> renewExpiredKit({
    required KitModel kitModel,
    required double value,
  }) async {
    emit(RenewKitLoadingState());
    try {
      KitModel tempKit = KitModel(
        name: kitModel.name,
        value: value,
        startDate: getFormattedDate(date: startDate),
        endDate: endDate != null ? getFormattedDate(date: endDate!) : null,
      );

      bool isUpdated = await SqfliteService.updateRecord(
        tableName: KitsStrings.tableName,
        data:
            '''value = ${kitModel.value}, isExpired = 0, startDate = '${tempKit.startDate}', endDate = '${tempKit.endDate}' ''',
        id: kitModel.getDbId,
      );

      if (isUpdated) {
        deleteKitFromList(kitModel);

        // Update current kit
        kitModel.setValue(value);
        kitModel.setIsExpired(false);
        kitModel.status = tempKit.status;
        kitModel.startDate = tempKit.startDate;
        kitModel.endDate = tempKit.endDate;

        addKitToList(kitModel);
        emit(RenewKitSuccessState(kitModel.name));
      } else {
        emit(RenewKitErrorState(kitModel.name));
      }
    } catch (e) {
      emit(RenewKitErrorState(kitModel.name));
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
        int aIndex = int.parse(a.name.substring(4));
        int bIndex = int.parse(b.name.substring(4));
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

  String? validateKitName(String? value) {
    if (value!.isEmpty) {
      return KitsStrings.enterNumber;
    }

    // Value is not empty
    else if (value.isNotEmpty) {
      // Check if the kit number already exists
      final bool exist = kits.any(
        (element) {
          return element.name == value;
        },
      );

      if (exist) {
        return KitsStrings.kitExists;
      }
    }

    return null;
  }

  String? validateKitValue(String? value) {
    if (value!.isEmpty) {
      return KitsStrings.enterValue;
    }

    return null;
  }

  String? validateStartDate() {
    if (startDate == null) {
      return KitsStrings.enterStartDate;
    }

    return null;
  }

  String? validateEndDate() {
    // If end date is before start date
    if (endDate != null && endDate!.isBefore(startDate!)) {
      return KitsStrings.endDateBeforeStartDate;
    }

    return null;
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

extension KitStatusStringMapper on KitStatus {
  String get name {
    switch (this) {
      case KitStatus.expired:
        return "Expired";
      case KitStatus.month12:
        return "12 Months";
      case KitStatus.month24:
        return "24 Months";
      case KitStatus.month30:
        return "30 Months";
      default:
        return "Normal";
    }
  }
}
