abstract class CalculatorStates {}

class CalculatorInitialState extends CalculatorStates {}

class LoadingDataState extends CalculatorStates {}

class DataLoadedSuccessState extends CalculatorStates {}

class DataLoadedFailedState extends CalculatorStates {}

class CalculateState extends CalculatorStates {}

class ClearState extends CalculatorStates {}
