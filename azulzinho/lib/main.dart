import 'package:azulzinho/app/calculator_app.dart';
import 'package:azulzinho/app/utils/bloc_observer.dart';
import 'package:azulzinho/app/utils/dependency_injection.dart';
import 'package:azulzinho/app/utils/functions.dart';
import 'package:azulzinho/app/utils/sqflite_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  try {
    WidgetsFlutterBinding.ensureInitialized();

    await SqfliteService.initialize();

    Bloc.observer = MyBlocObserver();

    getAppModules();

    runApp(const CalculatorApp());
  } catch (error) {
    kprint('Error in main: $error');
  }
}
