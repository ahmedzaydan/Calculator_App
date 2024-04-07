import 'package:calculator/app/utils/cache_controller.dart';
import 'package:calculator/app/utils/functions.dart';
import 'package:calculator/features/home/calculator_cubit/calculator_state.dart';
import 'package:calculator/features/kits/kit_cubit/kit_cubit.dart';
import 'package:calculator/features/kits/models/kit_model.dart';
import 'package:calculator/features/persons/person_cubit/persons_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CalculatorCubit extends Cubit<CalculatorStates> {
  CalculatorCubit(
    this.personsCubit,
    this.profitsCubit,
  ) : super(CalculatorInitialState());

  static CalculatorCubit get(context) => BlocProvider.of(context);

  final PersonsCubit personsCubit;
  final KitsCubit profitsCubit;

  String expenses = '';
  String note = '';
  String extra = '';

  double totalExpense = 0.0;
  double totalExtra = 0.0;

  double netProfit = 0.0;

  List<KitModel> profitItems = [];

  Future<void> init() async {
    emit(LoadingDataState());

    List<String> keys = CacheController.getAllKeys();
    List<String> profitKeys = [];
    List<String> personKeys = [];

    for (var key in keys) {
      if (key == personsCubit.amdinKey) {
        continue;
      } else if (key.startsWith(profitsCubit.kitKeyPrefix)) {
        profitKeys.add(key);
      } else {
        personKeys.add(key);
      }
    }

    await profitsCubit.loadData(profitKeys);
    await personsCubit.loadData(personKeys);

    emit(DataLoadedSuccessState());
  }

  double calculateString(String s) {
    double total = 0.0;
    List<String> values = s.split(',');
    for (var i = 0; i < values.length; i++) {
      if (values[i].isNotEmpty) {
        total += double.parse(values[i]);
      }
    }
    total = roundDouble(total);
    return total;
  }

  void calculate() {
    profitsCubit.calculateKits();

    totalExpense = calculateString(expenses);
    totalExtra = calculateString(extra);

    personsCubit.adminProfit =
        profitsCubit.totalKits * (personsCubit.adminPercentage / 100);
    personsCubit.adminProfit = roundDouble(personsCubit.adminProfit);

    netProfit = profitsCubit.totalKits -
        totalExpense -
        personsCubit.adminProfit +
        totalExtra;
    netProfit = roundDouble(netProfit);

    personsCubit.calculatePersonShareValues(netProfit);

    emit(CalculateState());
  }

  Future<void> clear() async {
    await profitsCubit.clearKits();
    expenses = '';
    extra = '';
    note = '';
    emit(ClearState());
  }
}
