import 'package:calculator/features/app_layout/app_layout_cubit/app_states.dart';

class PersonInitialState extends AppStates {}

// AddPerson states
class AddPersonLoadingState extends AppStates {}

class AddPersonSuccessState extends AppStates {}

class AddPersonErrorState extends AppStates {
  final String message;

  AddPersonErrorState(this.message);
}

// LoadPersonsData states
class LoadPersonsDataSuccessState extends AppStates {}

class LoadPersonsDataErrorState extends AppStates {
  final String message;

  LoadPersonsDataErrorState(this.message);
}

// SavePersonData states
class SavePersonDataSuccessState extends AppStates {}

class SavePersonDataErrorState extends AppStates {
  final String message;

  SavePersonDataErrorState(this.message);
}

// DeletePerson states
class DeletePersonSuccessState extends AppStates {}

class DeletePersonErrorState extends AppStates {
  final String message;

  DeletePersonErrorState(this.message);
}

// Admin states
class UpdateAdminPercentageSuccessState extends AppStates {}

class UpdateAdminPercentageErrorState extends AppStates {
  final String message;

  UpdateAdminPercentageErrorState(this.message);
}
