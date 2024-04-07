import 'package:calculator/app/resources/theme_manager.dart';
import 'package:calculator/app/utils/dependency_injection.dart';
import 'package:calculator/features/app_layout/app_layout_cubit/app_layout_cubit.dart';
import 'package:calculator/features/app_layout/app_layout_view.dart';
import 'package:calculator/features/home/calculator_cubit/calculator_cubit.dart';
import 'package:calculator/features/kits/kit_cubit/kit_cubit.dart';
import 'package:calculator/features/persons/person_cubit/persons_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CalculatorApp extends StatelessWidget {
  const CalculatorApp({super.key});

  @override
  Widget build(BuildContext context) {
    // return bloc providers
    return MultiBlocProvider(
      providers: [
        // app layout cubit
        BlocProvider<AppLayoutCubit>(
          create: (context) => locator<AppLayoutCubit>(),
          // build
        ),

        // calculator cubit
        BlocProvider<CalculatorCubit>(
          create: (context) => locator<CalculatorCubit>()..init(),
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
  }
}
