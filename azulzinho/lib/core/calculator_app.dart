import 'package:azulzinho/core/resources/theme_manager.dart';
import 'package:azulzinho/core/utils/dependency_injection.dart';
import 'package:azulzinho/features/app_layout/app_layout_cubit/app_cubit.dart';
import 'package:azulzinho/features/app_layout/app_layout_view.dart';
import 'package:azulzinho/features/calculator/calculator_cubit/calculator_cubit.dart';
import 'package:azulzinho/features/kits/kit_cubit/kit_cubit.dart';
import 'package:azulzinho/features/persons/person_cubit/persons_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CalculatorApp extends StatelessWidget {
  const CalculatorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, child) {
        return MultiBlocProvider(
          providers: [
            // app layout cubit
            BlocProvider<AppCubit>(
              create: (context) => locator<AppCubit>()..init(),
              // build
            ),

            // calculator cubit
            BlocProvider<CalculatorCubit>(
              create: (context) => locator<CalculatorCubit>(),
            ),

            // persons cubit
            BlocProvider<PersonsCubit>(
              create: (context) => locator<PersonsCubit>(),
            ),

            // profits cubit
            BlocProvider<KitsCubit>(
              create: (context) => locator<KitsCubit>(),
            ),
          ],
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            home: const AppLayout(),
            theme: getApplicationTheme(),
          ),
        );
      },
    );
  }
}
