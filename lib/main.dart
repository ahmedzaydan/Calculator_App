import 'package:azulzinho/calculator_app.dart';
import 'package:azulzinho/core/utils/bloc_observer.dart';
import 'package:azulzinho/core/utils/dependency_injection.dart';
import 'package:azulzinho/core/utils/sqflite_service.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

Future<void> init() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SqfliteService.initialize();
  await ScreenUtil.ensureScreenSize();
  Bloc.observer = MyBlocObserver();
  initializeDependencies();
}

void main() async {
  if (kReleaseMode) {
    await SentryFlutter.init(
      (options) async {
        await init();
        options.dsn =
            'https://27a813eb4ebcdfcf8e09c2f7fb5b9b19@o4508038351290368.ingest.de.sentry.io/4508038365249616';
        options.tracesSampleRate = .01;
      },
      appRunner: () => runApp(const CalculatorApp()),
    );
  } else {
    await init();
    runApp(const CalculatorApp());
  }
}
