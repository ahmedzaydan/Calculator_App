import 'package:calculator/features/app_layout/app_layout_cubit/app_cubit.dart';
import 'package:calculator/features/calculator/calculator_cubit/calculator_cubit.dart';
import 'package:calculator/features/kits/kit_cubit/kit_cubit.dart';
import 'package:calculator/features/persons/person_cubit/persons_cubit.dart';
import 'package:get_it/get_it.dart';

final GetIt locator = GetIt.instance;

void getAppModules() {
  // CalculatorCubit instance
  locator.registerLazySingleton<CalculatorCubit>(
    () => CalculatorCubit(
      locator<PersonsCubit>(),
      locator<KitsCubit>(),
    ),
  );

  // PersonsCubit instance
  locator.registerLazySingleton<PersonsCubit>(() => PersonsCubit());

  // KitsCubit instance
  locator.registerLazySingleton<KitsCubit>(() => KitsCubit());

  // AppLayoutCubit instance
  locator.registerLazySingleton<AppCubit>(
    () => AppCubit(
      locator<CalculatorCubit>(),
      locator<PersonsCubit>(),
      locator<KitsCubit>(),
    ),
  );
}
