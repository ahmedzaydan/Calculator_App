import 'package:calculator/features/home/calculator_cubit/calculator_cubit.dart';
import 'package:calculator/features/settings/persons/person_cubit/persons_cubit.dart';
import 'package:calculator/features/settings/profits/profit_cubit/profit_cubit.dart';
import 'package:get_it/get_it.dart';

// Import your dependencies here

final GetIt locator = GetIt.instance;

void getAppModules() {
  // PersonsCubit instance
  locator.registerLazySingleton<PersonsCubit>(() => PersonsCubit());

  // ProfitsCubit instance
  locator.registerLazySingleton<ProfitsCubit>(() => ProfitsCubit());

  // CalculatorCubit instance
  locator.registerLazySingleton<CalculatorCubit>(
    () => CalculatorCubit(
      locator<PersonsCubit>(),
      locator<ProfitsCubit>(),
    ),
  );
}
