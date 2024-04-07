import 'package:calculator/features/app_layout/app_layout_cubit/app_layout_cubit.dart';
import 'package:calculator/features/home/calculator_cubit/calculator_cubit.dart';
import 'package:calculator/features/kits/kit_cubit/kit_cubit.dart';
import 'package:calculator/features/persons/person_cubit/persons_cubit.dart';
import 'package:get_it/get_it.dart';

final GetIt locator = GetIt.instance;

void getAppModules() {
  // AppLayoutCubit instance
  locator.registerLazySingleton<AppLayoutCubit>(() => AppLayoutCubit());

  // CalculatorCubit instance
  locator.registerLazySingleton<CalculatorCubit>(
    () => CalculatorCubit(
      locator<PersonsCubit>(),
      locator<KitsCubit>(),
    ),
  );

  // PersonsCubit instance
  locator.registerLazySingleton<PersonsCubit>(() => PersonsCubit());

  // ProfitsCubit instance
  locator.registerLazySingleton<KitsCubit>(() => KitsCubit());
}
