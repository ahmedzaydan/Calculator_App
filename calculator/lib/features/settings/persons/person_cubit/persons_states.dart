abstract class PersonsStates {}

class PersonInitialState extends PersonsStates {}

// AddPerson states
class AddPersonLoadingState extends PersonsStates {}

class AddPersonSuccessState extends PersonsStates {}

class AddPersonErrorState extends PersonsStates {
  final String message;

  AddPersonErrorState(this.message);
}

// LoadPersonsData states
class LoadPersonsDataSuccessState extends PersonsStates {}

class LoadPersonsDataErrorState extends PersonsStates {
  final String message;

  LoadPersonsDataErrorState(this.message);
}

// SavePersonData states
class SavePersonDataSuccessState extends PersonsStates {}

class SavePersonDataErrorState extends PersonsStates {
  final String message;

  SavePersonDataErrorState(this.message);
}

// DeletePerson states
class DeletePersonSuccessState extends PersonsStates {}

class DeletePersonErrorState extends PersonsStates {
  final String message;

  DeletePersonErrorState(this.message);
}
