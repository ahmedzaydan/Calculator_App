abstract class CalculatorState {}

class CalculatorInitial extends CalculatorState {}

/// Home screen
class DataLoadedSuccessState extends CalculatorState {}

class DataLoadedFailedState extends CalculatorState {}

class CalculateState extends CalculatorState {}

class ProfitStatusChangedState extends CalculatorState {}

/// Settings screen
class AddProfitSuccessState extends CalculatorState {}

class AddProfitFailedState extends CalculatorState {
  final String message;

  AddProfitFailedState(this.message);
}

class ProfitsDataSavedState extends CalculatorState {}

class DeleteProfitSuccessState extends CalculatorState {}

// settings screen
class AddPersonSuccessState extends CalculatorState {}

class AddPersonErrorState extends CalculatorState {
  final String message;

  AddPersonErrorState(this.message);
}

class DeletePersonState extends CalculatorState {}

class PersonsDataSavedState extends CalculatorState {}

class ClearProfitItemsState extends CalculatorState {}

class ProfitKeysSortedState extends CalculatorState {}
