abstract class KitsStates {}

class KitsInitialState extends KitsStates {}

// AddKit states
class AddKitSuccessState extends KitsStates {}

class AddKitErrorState extends KitsStates {
  final String message;

  AddKitErrorState(this.message);
}

// LoadKitsData states
class LoadKitsDataSuccessState extends KitsStates {}

class LoadKitsDataErrorState extends KitsStates {
  final String message;

  LoadKitsDataErrorState(this.message);
}

// UpdateKitsData states
class UpdateKitDataSuccessState extends KitsStates {}

class UpdateKitDataErrorState extends KitsStates {
  final String message;

  UpdateKitDataErrorState(this.message);
}

// Change Kit status states
class KitStatusChangedSuccessState extends KitsStates {}

class KitStatusChangedErrorState extends KitsStates {
  final String message;

  KitStatusChangedErrorState(this.message);
}

// Clear Kit items states
class ClearKitItemsSuccessState extends KitsStates {}

class ClearKitItemsErrorState extends KitsStates {
  final String message;

  ClearKitItemsErrorState(this.message);
}

class KitsSortedState extends KitsStates {}

// DeleteKit states
class DeleteKitSuccessState extends KitsStates {}

class DeleteKitErrorState extends KitsStates {
  final String message;

  DeleteKitErrorState(this.message);
}
