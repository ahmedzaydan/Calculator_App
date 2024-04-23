import 'package:azulzinho/features/app_layout/app_layout_cubit/app_states.dart';

class KitsInitialState extends AppStates {}

// AddKit states
class AddKitLoadingState extends AppStates {}

class AddKitSuccessState extends AppStates {
  final String message;

  AddKitSuccessState(this.message);
}

class AddKitErrorState extends AppStates {
  final String message;

  AddKitErrorState(this.message);
}

// LoadKitsData states
class LoadKitsDataLoadingState extends AppStates {
  final String message;

  LoadKitsDataLoadingState(this.message);
}

class LoadKitsDataSuccessState extends AppStates {}

class LoadingKitsDataErrorState extends AppStates {
  final String message;

  LoadingKitsDataErrorState(this.message);
}

// UpdateKitsData states
class UpdateKitSuccessState extends AppStates {
  final String message;

  UpdateKitSuccessState(this.message);
}

class UpdateKitErrorState extends AppStates {
  final String message;

  UpdateKitErrorState(this.message);
}

// Change Kit status states
class KitCheckedStatusChangedSuccessState extends AppStates {}

class KitCheckedStatusChangedErrorState extends AppStates {
  final String message;

  KitCheckedStatusChangedErrorState(this.message);
}

// Clear Kit items states
class ClearKitItemsSuccessState extends AppStates {}

class ClearKitItemsErrorState extends AppStates {
  final String message;

  ClearKitItemsErrorState(this.message);
}

class KitsSortedState extends AppStates {}

// DeleteKit states
class DeleteKitSuccessState extends AppStates {
  final String message;

  DeleteKitSuccessState(this.message);
}

class DeleteKitErrorState extends AppStates {
  final String message;

  DeleteKitErrorState(this.message);
}

// toggle kit lists visibility
class ToggleKitListVisibilityState extends AppStates {}
