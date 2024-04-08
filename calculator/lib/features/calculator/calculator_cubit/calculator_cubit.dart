import 'package:calculator/app/utils/functions.dart';
import 'package:calculator/features/app_layout/app_layout_cubit/app_states.dart';
import 'package:calculator/features/calculator/calculator_cubit/calculator_state.dart';
import 'package:calculator/features/kits/kit_cubit/kit_cubit.dart';
import 'package:calculator/features/persons/person_cubit/persons_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CalculatorCubit extends Cubit<AppStates> {
  CalculatorCubit(
    this.personsCubit,
    this.kitCubit,
  ) : super(CalculatorInitialState());

  static CalculatorCubit get(context) => BlocProvider.of(context);
  final PersonsCubit personsCubit;
  final KitsCubit kitCubit;

  String expenses = '';
  String note = '';
  String extra = '';

  double totalExpense = 0.0;
  double totalExtra = 0.0;

  double netProfit = 0.0;

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
    kitCubit.calculateKits();

    totalExpense = calculateString(expenses);
    totalExtra = calculateString(extra);

    personsCubit.adminProfit =
        kitCubit.totalKits * (personsCubit.adminPercentage / 100);
    personsCubit.adminProfit = roundDouble(personsCubit.adminProfit);

    netProfit = kitCubit.totalKits -
        totalExpense -
        personsCubit.adminProfit +
        totalExtra;
    netProfit = roundDouble(netProfit);

    personsCubit.calculatePersonsShareValues(netProfit);

    emit(CalculateState());
  }

  Future<void> clear() async {
    await kitCubit.clearKits();
    expenses = '';
    extra = '';
    note = '';
    emit(ClearState());
  }
}
