abstract class CalculatorState {}

class CalculatorInitial extends CalculatorState {}

/// Home screen
class DataLoadedSuccessState extends CalculatorState {}

class DataLoadedFailedState extends CalculatorState {}

class CalculateState extends CalculatorState {}

class ChangeProfitStatusState extends CalculatorState {}

/// Settings screen
class AddProfitState extends CalculatorState {}

class AddProfitFailedState extends CalculatorState {
  final String message;

  AddProfitFailedState(this.message);
}

class ProfitsDataSavedState extends CalculatorState {}

class DeleteProfitState extends CalculatorState {}

// settings screen
class AddPersonState extends CalculatorState {}

class AddPersonFieldState extends CalculatorState {
  final String message;

  AddPersonFieldState(this.message);
}

class DeletePersonState extends CalculatorState {}

class PersonsDataSavedState extends CalculatorState {}

class ClearProfitItemsState extends CalculatorState {}

class ProfitKeysSortedState extends CalculatorState {}