import 'package:azulzinho/app/calculator_app.dart';
import 'package:azulzinho/app/utils/bloc_observer.dart';
import 'package:azulzinho/app/utils/cache_controller.dart';
import 'package:azulzinho/app/utils/dependency_injection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Prefs.init();

  Bloc.observer = MyBlocObserver();

  getAppModules();

  runApp(const CalculatorApp());
}
