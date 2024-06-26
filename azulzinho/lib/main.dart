import 'package:azulzinho/core/calculator_app.dart';
import 'package:azulzinho/core/utils/bloc_observer.dart';
import 'package:azulzinho/core/utils/dependency_injection.dart';
import 'package:azulzinho/core/utils/functions.dart';
import 'package:azulzinho/core/utils/sqflite_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  try {
    WidgetsFlutterBinding.ensureInitialized();

    await SqfliteService.initialize();

    Bloc.observer = MyBlocObserver();

    getAppModules();

    await Future.delayed(const Duration(milliseconds: 150));

    runApp(const CalculatorApp());
  } catch (error) {
    kprint('Error in main: $error');
  }
}
