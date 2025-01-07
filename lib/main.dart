import 'dart:async';

import 'package:azulzinho/calculator_app.dart';
import 'package:azulzinho/core/utils/bloc_observer.dart';
import 'package:azulzinho/core/utils/dependency_injection.dart';
import 'package:azulzinho/core/utils/functions.dart';
import 'package:azulzinho/core/utils/sqflite_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'core/widgets/error_screen.dart';

Future<void> init() async {
  kprint('Starting initialization...');
  await requestStoragePermission();
  await SqfliteService.initialize();
  await ScreenUtil.ensureScreenSize();
  Bloc.observer = MyBlocObserver();
  initializeDependencies();
  kprint('Initialization completed');
}

void main() {
  // Set up error handling before any async operations
  FlutterError.onError = (FlutterErrorDetails details) {
    kprint('Flutter Error: ${details.toString()}');
    runApp(
      MaterialApp(
        home: ErrorScreen(
          error: details.exception.toString(),
          stackTrace: details.stack.toString(),
        ),
      ),
    );
  };

  // Wrap everything in a single runZonedGuarded
  runZonedGuarded(
    () async {
      // Initialize Flutter bindings inside the same zone
      WidgetsFlutterBinding.ensureInitialized();

      try {
        await init();
        runApp(const CalculatorApp());
      } catch (error, stackTrace) {
        kprint('Fatal initialization error: $error');
        kprint('Stack trace: $stackTrace');

        runApp(
          MaterialApp(
            home: ErrorScreen(
              error: error.toString(),
              stackTrace: stackTrace.toString(),
            ),
          ),
        );
      }
    },
    (error, stackTrace) {
      kprint('Uncaught error: $error');
      kprint('Stack trace: $stackTrace');

      runApp(
        MaterialApp(
          home: ErrorScreen(
            error: error.toString(),
            stackTrace: stackTrace.toString(),
          ),
        ),
      );
    },
  );
}
