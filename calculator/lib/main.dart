import 'package:calculator/app/calculator_app.dart';
import 'package:calculator/app/utils/bloc_observer.dart';
import 'package:calculator/app/utils/cache_controller.dart';
import 'package:calculator/app/utils/dependency_injection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// TODO: all text styles from style manager
// only 28 and 32 and 24
// add item for person and kit
// organize your code and remove unsed code
// put functions in classes
// choose best background for inkwell

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Prefs.init();

  Bloc.observer = MyBlocObserver();

  getAppModules();

  runApp(const CalculatorApp());
}
