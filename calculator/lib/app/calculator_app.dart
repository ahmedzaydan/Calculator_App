import 'package:calculator/app/resources/theme_manager.dart';
import 'package:calculator/app/utils/dependency_injection.dart';
import 'package:calculator/features/home/calculator_cubit/calculator_cubit.dart';
import 'package:calculator/features/home/views/home_view.dart';
import 'package:calculator/features/settings/persons/person_cubit/persons_cubit.dart';
import 'package:calculator/features/settings/profits/profit_cubit/profit_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CalculatorApp extends StatelessWidget {
  const CalculatorApp({super.key});

  @override
  Widget build(BuildContext context) {
    // return bloc providers
    return MultiBlocProvider(
      providers: [
        // calculator cubit
        BlocProvider<CalculatorCubit>(
          create: (context) => locator<CalculatorCubit>()..init(),
        ),

        // persons cubit
        BlocProvider<PersonsCubit>(
          create: (context) => locator<PersonsCubit>(),
        ),

        // profits cubit
        BlocProvider<ProfitsCubit>(
          create: (context) => locator<ProfitsCubit>(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: const HomeView(),
        theme: getApplicationTheme(),
      ),
    );
  }
}
