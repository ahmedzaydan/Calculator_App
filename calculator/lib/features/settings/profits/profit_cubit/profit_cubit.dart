import 'package:calculator/app/resources/strings_manager.dart';
import 'package:calculator/app/utils/cache_controller.dart';
import 'package:calculator/app/utils/extensions.dart';
import 'package:calculator/app/utils/functions.dart';
import 'package:calculator/features/settings/profits/models/profit_model.dart';
import 'package:calculator/features/settings/profits/profit_cubit/profit_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfitsCubit extends Cubit<ProfitsStates> {
  ProfitsCubit() : super(ProfitInitialState());
  final String profitKeysKey = 'profitKeys';

  double totalProfit = 0.0;
  String checkedProfits = '';
  String profitKeyPrefix = 'kit';

  List<ProfitModel> profitItems = [];
  Future<void> loadData(List<String> profitKeys) async {
    try {
      kprint('Profit keys: $profitKeys');
      for (String key in profitKeys) {
        List<String> profitData =
            CacheController.getStringListData(key).orEmpty;

        if (profitData.isNotEmpty) {
          ProfitModel profit = ProfitModel.fromStringList(profitData);
          profitItems.add(profit);
        }
      }

      emit(LoadProfitsDataSuccessState());
    } catch (e) {
      emit(LoadProfitsDataErrorState(e.toString()));
    }
  }

  Future<void> addProfit({
    required String id,
    required double value,
  }) async {
    try {
      String storingKey = _getStoringKey(id);
      if (CacheController.checkKey(storingKey) == false) {
        // create profit object
        ProfitModel profit = ProfitModel(
          id: storingKey,
          value: value,
        );

        // add profit to shared preferences
        CacheController.saveData(profit.id, profit.toStringList())
            .then((addResult) {
          if (addResult) {
            // add profit to the profitItems list
            profitItems.add(profit);

            emit(AddProfitSuccessState());
            sortProfits();
          } else {
            emit(AddProfitErrorState(StringsManager.defaultError));
          }
        });
      } else {
        emit(AddProfitErrorState(StringsManager.profitExists));
      }
    } catch (e) {
      emit(AddProfitErrorState(e.toString()));
    }
  }

  String _getStoringKey(String id) => 'kit$id';

  Future<void> updateProfitValue({
    required int index,
    required String value,
  }) async {
    try {
      CacheController.saveData(
        profitItems[index].id,
        profitItems[index].toStringList(),
      ).then((updateResult) {
        if (updateResult) {
          profitItems[index].setValue(value);
          emit(UpdateProfitDataSuccessState());
          sortProfits();
        } else {
          emit(UpdateProfitDataErrorState(StringsManager.defaultError));
        }
      });
    } catch (e) {
      emit(UpdateProfitDataErrorState(e.toString()));
    }
  }

  Future<void> changeProfitStatus(int index) async {
    try {
      profitItems[index].toggleStatus();
      await CacheController.saveData(
        profitItems[index].id,
        profitItems[index].toStringList(),
      );

      emit(ProfitStatusChangedSuccessState());
    } catch (e) {
      emit(ProfitStatusChangedErrorState(e.toString()));
    }
  }

  Future<void> clearProfits() async {
    try {
      for (ProfitModel profit in profitItems) {
        profit.setStatus(false);

        await CacheController.saveData(
          profit.id,
          profit.toStringList(),
        );

        emit(ClearProfitItemsSuccessState());
      }
    } catch (e) {
      emit(ClearProfitItemsErrorState(e.toString()));
    }
  }

  void sortProfits() {
    profitItems.sort(
      (a, b) {
        int aIndex = int.parse(a.id.substring(profitKeyPrefix.length));
        int bIndex = int.parse(b.id.substring(profitKeyPrefix.length));
        return aIndex.compareTo(bIndex);
      },
    );
    emit(ProfitKeysSortedState());
  }

  void calculateProfit() {
    totalProfit = 0;
    checkedProfits = '';

    for (var profit in profitItems) {
      if (profit.isChecked) {
        totalProfit += profit.value;
        checkedProfits += profit.format;
      }
    }

    if (checkedProfits.isNotEmpty) {
      checkedProfits = checkedProfits.substring(0, checkedProfits.length - 4);
    }

    totalProfit = roundDouble(totalProfit);
  }

  Future<void> deleteProfitItem(int index) async {
    try {
      CacheController.removeData(profitItems[index].id).then((result) {
        if (result) {
          emit(DeleteProfitSuccessState());
          profitItems.removeAt(index);
          sortProfits();
        } else {
          emit(DeleteProfitErrorState(StringsManager.defaultError));
        }
      });

      emit(DeleteProfitSuccessState());
    } catch (e) {
      emit(DeleteProfitErrorState(e.toString()));
    }
  }
}
