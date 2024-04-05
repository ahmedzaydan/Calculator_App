import 'package:calculator/app/calculator_cubit/calculator_cubit.dart';
import 'package:get_it/get_it.dart';

// Import your dependencies here

final GetIt locator = GetIt.instance;

void getAppModules() {
  // CalculatorCubit instance
  locator.registerFactory<CalculatorCubit>(() => CalculatorCubit());
}