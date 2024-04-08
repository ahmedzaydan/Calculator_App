abstract class AppStates {}

class AppLayoutInitialState extends AppStates {}

class LoadingDataState extends AppStates {}

class LoadingDataSuccessState extends AppStates {}

class LoadingDataErrorState extends AppStates {
  final String message;

  LoadingDataErrorState(this.message);
}

class ChangeBottomNavIndexState extends AppStates {
  final int index;

  ChangeBottomNavIndexState(this.index);
}
