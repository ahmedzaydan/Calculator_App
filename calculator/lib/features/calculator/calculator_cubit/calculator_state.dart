import 'package:calculator/features/app_layout/app_layout_cubit/app_states.dart';

class CalculatorInitialState extends AppStates {}

class CalculateState extends AppStates {}

class ClearState extends AppStates {}

// sharing report states
class ShareLoadingState extends AppStates {}

class ShareSuccessState extends AppStates {}

class ShareErrorState extends AppStates {
  final String message;

  ShareErrorState(this.message);
}