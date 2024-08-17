import 'package:azulzinho/calculator_app.dart';
import 'package:azulzinho/core/utils/bloc_observer.dart';
import 'package:azulzinho/core/utils/dependency_injection.dart';
import 'package:azulzinho/core/utils/functions.dart';
import 'package:azulzinho/core/utils/sqflite_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() async {
  try {
    WidgetsFlutterBinding.ensureInitialized();
    await SqfliteService.initialize();
    await ScreenUtil.ensureScreenSize();
    Bloc.observer = MyBlocObserver();
    initializeDependencies();

    // handle report view
    // handle laoding, error widgets and empty widgets
    runApp(const CalculatorApp());
    // runApp(MyApp());
  } catch (error) {
    kprint('Error in main: $error');
  }
}
