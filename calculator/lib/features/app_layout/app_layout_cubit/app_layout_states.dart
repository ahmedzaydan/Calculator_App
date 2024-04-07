abstract class AppLayoutStates {}

class AppLayoutInitialState extends AppLayoutStates {}

class ChangeBottomNavIndexState extends AppLayoutStates {
  final int index;

  ChangeBottomNavIndexState(this.index);
}