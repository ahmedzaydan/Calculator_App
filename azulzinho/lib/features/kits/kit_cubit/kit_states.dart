import 'package:azulzinho/app/resources/strings_manager.dart';
import 'package:azulzinho/features/app_layout/app_layout_cubit/app_states.dart';

class KitsInitialState extends AppStates {}

/// Create kit states
class CreateKitLoadingState extends AppStates {
  final String message = KitsStrings.loadingKits;
}

class CreateKitSuccessState extends AppStates {
  final String name;

  CreateKitSuccessState(this.name);

  String get message {
    return '$name adicionado com sucesso';
  }
}

class CreateKitErrorState extends AppStates {
  final String name;
  final String? error;

  CreateKitErrorState(this.name, {this.error});

  String get message {
    return error ?? 'Falha ao adicionar $name';
  }
}

/// Fetch kits data states
class FetchKitsDataLoadingState extends AppStates {
  String get message {
    return KitsStrings.loadingKits;
  }
}

class FetchKitsSuccessState extends AppStates {}

class FetchKitsErrorState extends AppStates {
  String get message {
    return 'Falha ao carregar os dados dos kits';
  }
}

/// Update Kit states
class UpdateKitSuccessState extends AppStates {
  final String name;

  String get message {
    return 'Valor $name atualizado com sucesso';
  }

  UpdateKitSuccessState(this.name);
}

class UpdateKitErrorState extends AppStates {
  final String? error;
  final String name;

  String get message {
    return error ?? 'Falha ao atualizar o valor de $name';
  }

  UpdateKitErrorState(this.name, {this.error});
}

/// Change Kit status states
class ToggleKitCheckedStatusSuccessState extends AppStates {}

class ToggleKitCheckedStatusErrorState extends AppStates {
  final String message;

  ToggleKitCheckedStatusErrorState(this.message);
}

// Clear Kit items states
class ClearKitItemsSuccessState extends AppStates {}

class ClearKitItemsErrorState extends AppStates {
  final String message;

  ClearKitItemsErrorState(this.message);
}

/// Delete Kit states
class DeleteKitSuccessState extends AppStates {
  final String name;

  String get message {
    return '$name excluído com sucesso';
  }

  DeleteKitSuccessState(this.name);
}

class DeleteKitErrorState extends AppStates {
  final String name;

  String get message {
    return 'Falha ao excluir $name';
  }

  DeleteKitErrorState(this.name);
}

// toggle kit lists visibility
class ToggleKitListVisibilityState extends AppStates {}

// Kits sorted states
class KitsSortedState extends AppStates {}
