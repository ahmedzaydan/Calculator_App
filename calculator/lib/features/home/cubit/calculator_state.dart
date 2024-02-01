abstract class CalculatorState {}

class CalculatorInitial extends CalculatorState {}

class AddFieldState extends CalculatorState {}

class DeleteProfitFieldState extends CalculatorState {}

class DeleteExpenseFieldState extends CalculatorState {}

class ValueAddedState extends CalculatorState {}

class CalculateState extends CalculatorState {}


// settings screen
class AddPersonState extends CalculatorState {}

class DeletePersonState extends CalculatorState {}

class DataSavedState extends CalculatorState {}

class DataLoadedSuccessState extends CalculatorState {}

class DataLoadedFailedState extends CalculatorState {}