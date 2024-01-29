import 'package:calculator/bloc_observer.dart';
import 'package:calculator/cache_controller.dart';
import 'package:calculator/cubit/calculator_cubit.dart';
import 'package:calculator/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await CacheController.init();

  Bloc.observer = MyBlocObserver();
  runApp(const CalculatorApp());
}

class CalculatorApp extends StatelessWidget {
  const CalculatorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CalculatorCubit>(
      create: (context) => CalculatorCubit()..loadData(),
      child: const MaterialApp(
        title: 'Calculator',
        debugShowCheckedModeBanner: false,
        home: HomeScreen(),
      ),
    );
  }
}
