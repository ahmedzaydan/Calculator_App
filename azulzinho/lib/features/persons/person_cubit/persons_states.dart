import 'package:azulzinho/app/resources/strings_manager.dart';
import 'package:azulzinho/features/app_layout/app_layout_cubit/app_states.dart';

class PersonInitialState extends AppStates {}

/// Create person states
class CreatePersonLoadingState extends AppStates {}

class CreatePersonSuccessState extends AppStates {
  final String name;

  String get message {
    return '$name adicionado com sucesso';
  }

  CreatePersonSuccessState(this.name);
}

class CreatePersonErrorState extends AppStates {
  final String? error;
  final String name;

  String get message {
    return error ?? 'Falha ao adicionar $name';
  }

  CreatePersonErrorState(this.name, {this.error});
}

/// Fetch persons data states
class FetchPersonsLoadingState extends AppStates {
  String get message {
    return PersonsStrings.loadingPersons;
  }

  FetchPersonsLoadingState();
}

class FetchPersonsSuccessState extends AppStates {}

class FetchPersonsErrorState extends AppStates {
  String get message {
    return 'Falha ao carregar os dados das pessoas';
  }

  FetchPersonsErrorState();
}

/// Update person states
class UpdatePersonSuccessState extends AppStates {
  final String name;

  String get message {
    return 'Porcentagem de $name atualizada com sucesso';
  }

  UpdatePersonSuccessState(this.name);
}

class UpdatePersonErrorState extends AppStates {
  final String name;

  final String? error;

  String get message {
    return error ?? 'Falha ao atualizar a porcentagem de $name';
  }

  UpdatePersonErrorState(this.name, {this.error});
}

/// Delete person states
class DeletePersonSuccessState extends AppStates {
  final String name;

  String get message {
    return '$name excluído com sucesso';
  }

  DeletePersonSuccessState(this.name);
}

class DeletePersonErrorState extends AppStates {
  final String? error;
  final String name;

  String get message {
    return error ?? 'Falha ao excluir $name';
  }

  DeletePersonErrorState(this.name, {this.error});
}
