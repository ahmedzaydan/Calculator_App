abstract class ProfitsStates {}

class ProfitInitialState extends ProfitsStates {}

// AddProfit states
class AddProfitSuccessState extends ProfitsStates {}

class AddProfitErrorState extends ProfitsStates {
  final String message;

  AddProfitErrorState(this.message);
}

// LoadProfitsData states
class LoadProfitsDataSuccessState extends ProfitsStates {}

class LoadProfitsDataErrorState extends ProfitsStates {
  final String message;

  LoadProfitsDataErrorState(this.message);
}

// UpdateProfitsData states
class UpdateProfitDataSuccessState extends ProfitsStates {}

class UpdateProfitDataErrorState extends ProfitsStates {
  final String message;

  UpdateProfitDataErrorState(this.message);
}

// Change profit status states
class ProfitStatusChangedSuccessState extends ProfitsStates {}

class ProfitStatusChangedErrorState extends ProfitsStates {
  final String message;

  ProfitStatusChangedErrorState(this.message);
}

// Clear profit items states
class ClearProfitItemsSuccessState extends ProfitsStates {}

class ClearProfitItemsErrorState extends ProfitsStates {
  final String message;

  ClearProfitItemsErrorState(this.message);
}

class ProfitKeysSortedState extends ProfitsStates {}

// DeleteProfit states
class DeleteProfitSuccessState extends ProfitsStates {}

class DeleteProfitErrorState extends ProfitsStates {
  final String message;

  DeleteProfitErrorState(this.message);
}

class SaveProfitKeysSuccessState extends ProfitsStates {}

class SaveProfitKeysErrorState extends ProfitsStates {
  final String message;

  SaveProfitKeysErrorState(this.message);
}