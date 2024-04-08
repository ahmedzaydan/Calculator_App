import 'package:calculator/app/calculator_app.dart';
import 'package:calculator/app/utils/bloc_observer.dart';
import 'package:calculator/app/utils/cache_controller.dart';
import 'package:calculator/app/utils/dependency_injection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await CacheController.init();

  Bloc.observer = MyBlocObserver();

  getAppModules();

  runApp(const CalculatorApp());
}

/// ToDos:
// TODO: finish kits screen
  // coloring, sorting based on color
// TODO: Persons screen
  // admin field like other persons with some highlighted color
// TODO: Calculator screen
  // kits scrollable section 
// TODO: Report screen (choose better name?)
  // share button
  // back arrow ios
// TODO: all icons should be FaIcons