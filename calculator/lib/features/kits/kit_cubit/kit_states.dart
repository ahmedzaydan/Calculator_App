import 'package:calculator/features/app_layout/app_layout_cubit/app_states.dart';

class KitsInitialState extends AppStates {}

// AddKit states
class AddKitLoadingState extends AppStates {}

class AddKitSuccessState extends AppStates {}

class AddKitErrorState extends AppStates {
  final String message;

  AddKitErrorState(this.message);
}

// LoadKitsData states
class LoadKitsDataLoadingState extends AppStates {}

class LoadKitsDataSuccessState extends AppStates {}

class LoadKitsDataErrorState extends AppStates {
  final String message;

  LoadKitsDataErrorState(this.message);
}

// UpdateKitsData states
class UpdateKitDataSuccessState extends AppStates {}

class UpdateKitDataErrorState extends AppStates {
  final String message;

  UpdateKitDataErrorState(this.message);
}

// Change Kit status states
class KitStatusChangedSuccessState extends AppStates {}

class KitStatusChangedErrorState extends AppStates {
  final String message;

  KitStatusChangedErrorState(this.message);
}

// Clear Kit items states
class ClearKitItemsSuccessState extends AppStates {}

class ClearKitItemsErrorState extends AppStates {
  final String message;

  ClearKitItemsErrorState(this.message);
}

class KitsSortedState extends AppStates {}

// DeleteKit states
class DeleteKitSuccessState extends AppStates {}

class DeleteKitErrorState extends AppStates {
  final String message;

  DeleteKitErrorState(this.message);
}
