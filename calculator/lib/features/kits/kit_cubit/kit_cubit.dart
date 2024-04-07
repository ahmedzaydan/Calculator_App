import 'package:calculator/app/resources/strings_manager.dart';
import 'package:calculator/app/utils/cache_controller.dart';
import 'package:calculator/app/utils/extensions.dart';
import 'package:calculator/app/utils/functions.dart';
import 'package:calculator/features/kits/kit_cubit/kit_states.dart';
import 'package:calculator/features/kits/models/kit_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class KitsCubit extends Cubit<KitsStates> {
  KitsCubit() : super(KitsInitialState());

  double totalKits = 0.0;
  String checkedkits = '';
  String kitKeyPrefix = 'kit';

  List<KitModel> kitItems = [];
  Future<void> loadData(List<String> kitKeys) async {
    try {
      for (String key in kitKeys) {
        List<String> kitData = CacheController.getStringListData(key).orEmpty;

        if (kitData.isNotEmpty) {
          KitModel kit = KitModel.fromStringList(kitData);
          kitItems.add(kit);
        }
      }

      emit(LoadKitsDataSuccessState());
    } catch (e) {
      emit(LoadKitsDataErrorState(e.toString()));
    }
  }

  Future<void> addKit({
    required String id,
    required double value,
  }) async {
    try {
      String storingKey = _getStoringKey(id);
      if (CacheController.checkKey(storingKey) == false) {
        // create kit object
        KitModel kit = KitModel(
          id: storingKey,
          value: value,
        );

        // add kit to shared preferences
        CacheController.saveData(kit.id, kit.toStringList()).then((addResult) {
          if (addResult) {
            // add kit to the kitItems list
            kitItems.add(kit);
            emit(AddKitSuccessState());
            sortKits();
          } else {
            emit(AddKitErrorState(StringsManager.defaultError));
          }
        });
      } else {
        emit(AddKitErrorState(StringsManager.kitExists));
      }
    } catch (e) {
      emit(AddKitErrorState(e.toString()));
    }
  }

  String _getStoringKey(String id) => 'kit$id';

  Future<void> updateKitValue({
    required int index,
    required String value,
  }) async {
    try {
      CacheController.saveData(
        kitItems[index].id,
        kitItems[index].toStringList(),
      ).then((updateResult) {
        if (updateResult) {
          kitItems[index].setValue(value);
          emit(UpdateKitDataSuccessState());
          sortKits();
        } else {
          emit(UpdateKitDataErrorState(StringsManager.defaultError));
        }
      });
    } catch (e) {
      emit(UpdateKitDataErrorState(e.toString()));
    }
  }

  Future<void> changeKitStatus(int index) async {
    try {
      kitItems[index].toggleStatus();
      await CacheController.saveData(
        kitItems[index].id,
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
        kit.setStatus(false);

        await CacheController.saveData(
          kit.id,
          kit.toStringList(),
        );

        emit(ClearKitItemsSuccessState());
      }
    } catch (e) {
      emit(ClearKitItemsErrorState(e.toString()));
    }
  }

  void sortKits() {
    kitItems.sort(
      (a, b) {
        int aIndex = int.parse(a.id.substring(kitKeyPrefix.length));
        int bIndex = int.parse(b.id.substring(kitKeyPrefix.length));
        return aIndex.compareTo(bIndex);
      },
    );
    emit(KitsSortedState());
  }

  void calculateKits() {
    totalKits = 0;
    checkedkits = '';

    for (var kit in kitItems) {
      if (kit.isChecked) {
        totalKits += kit.value;
        checkedkits += kit.format;
      }
    }

    if (checkedkits.isNotEmpty) {
      // TODO: check if this is correct
      checkedkits = checkedkits.substring(0, checkedkits.length - 4);
    }

    totalKits = roundDouble(totalKits);
  }

  Future<void> deleteKitItem(int index) async {
    try {
      CacheController.removeData(kitItems[index].id).then((result) {
        if (result) {
          emit(DeleteKitSuccessState());
          kitItems.removeAt(index);
          sortKits();
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
