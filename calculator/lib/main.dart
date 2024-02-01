import 'package:calculator/core/bloc_observer.dart';
import 'package:calculator/core/cache_controller.dart';
import 'package:calculator/features/home/cubit/calculator_cubit.dart';
import 'package:calculator/features/home/views/home_view.dart';
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
        home: HomeView(),
        // theme: ThemeData(
        //   primarySwatch: Colors.deepOrange,
        //   primaryColor: Colors.black,
        //   scaffoldBackgroundColor: Colors.white,
        //   appBarTheme: const AppBarTheme(
        //     backgroundColor: Colors.white,
        //     elevation: 0,
        //     iconTheme: IconThemeData(
        //       color: Colors.black,
        //     ),
        //   ),
        // ),
      ),
    );
  } // TODO: change primarySwatch to good color
}
