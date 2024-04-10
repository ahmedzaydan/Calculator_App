import 'package:calculator/features/app_layout/app_layout_cubit/app_states.dart';

class PersonInitialState extends AppStates {}

// AddPerson states
class AddPersonLoadingState extends AppStates {}

class AddPersonSuccessState extends AppStates {
  final String message;

  AddPersonSuccessState(this.message);
}

class AddPersonErrorState extends AppStates {
  final String message;

  AddPersonErrorState(this.message);
}

// LoadPersonsData states
class LoadPersonsDataLoadingState extends AppStates {
  final String message;

  LoadPersonsDataLoadingState(this.message);
}

class LoadPersonsDataSuccessState extends AppStates {}

class LoadPersonsDataErrorState extends AppStates {
  final String message;

  LoadPersonsDataErrorState(this.message);
}

// Update person states
class UpdatePersonSuccessState extends AppStates {
  final String message;

  UpdatePersonSuccessState(this.message);
}

class UpdatePersonErrorState extends AppStates {
  final String message;

  UpdatePersonErrorState(this.message);
}

// DeletePerson states
class DeletePersonSuccessState extends AppStates {
  final String message;

  DeletePersonSuccessState(this.message);
}

class DeletePersonErrorState extends AppStates {
  final String message;

  DeletePersonErrorState(this.message);
}

// Admin states
class UpdateAdminSuccessState extends AppStates {
  final String message;

  UpdateAdminSuccessState(this.message);
}

class UpdateAdminPercentageErrorState extends AppStates {
  final String message;

  UpdateAdminPercentageErrorState(this.message);
}
