abstract class StringsManager {
  static const String emptyString = '';
  static const String loading = 'Carregando...';
  static const String dataLoadingError =
      'Ocorreu um erro ao carregar os dados, por favor, tente novamente mais tarde';
  static const String defaultError = 'Ocorreu um erro';
  static const String delete = 'Excluir';
  static const String update = 'Atualizar';
  static const String cancel = 'Cancelar';
  static const String enterName = 'Digite o nome';

  static const String status = 'status';
}

abstract class PersonsStrings {
  static const String admin = 'Teresa';
  static const String name = 'Nome da Pessoa';
  static const String personsScreen = 'Pessoas';
  static const String add = 'Adicionar';
  static const String addPerson = 'Adicionar Nova Pessoa';
  static const String percentage = 'Porcentagem da Pessoa';
  static const String enterPercentage = 'Digite a porcentagem';
  static const String personExists = 'Nome da pessoa já existe';
  static const String percentageError =
      'A porcentagem total deve ser inferior a 100';
  static const String invalidPercentage =
      'A porcentagem deve ser um número entre 0 e 100';
  static const String loadingPersons = 'Carregando dados das pessoas...';
  static const String deleteConfirmation =
      'Você tem certeza de que deseja excluir esta pessoa?';
}

abstract class KitsStrings {
  static const String kitsScreen = 'Kits';
  static const String editKitList = 'Editar Lista de Kits';
  static const String kitNumber = 'Número do Kit';
  static const String kitValue = 'Valor do Kit';
  static const String enterValue = 'Digite o valor';
  static const String enterNumber = 'Digite o número do kit';
  static const String enterStartDate = "Digite a data";
  static const String startDate = "Data de início";
  static const String kitExists = 'Kit já existe';
  static const String invalidProfitId =
      'Número do kit deve ser um número inteiro';
  static const String addKit = 'Adicionar Novo Kit';
  static const String loadingKits = 'Carregando dados dos kits...';
  static const String month12 = '1° Reajuste';
  static const String month24 = '2° Reajuste';
  static const String month30 = 'Renovar';
  static const String expired = 'Expirado';
  static const String normal = 'Normal';
  static const String deleteConfirmation =
      'Você tem certeza de que deseja excluir este kit?';
  static const String add = 'Adicionar';
  static const String history = 'História';
  static const String historyTitle = 'Histórico de Kits Expirados';
}

abstract class CalculatorStrings {
  // calculator screen strings
  static const String calculatorScreen = 'Calculadora';
  static const String kits = 'Kits';
  static const String expenses = 'Despesas';
  static const expansesHint = 'valor1, valor2,';
  static const String extra = 'Extra';
  static const String note = 'Nota';
  static const String clear = 'Limpar';
  static const String calculate = 'Calcular';

  // report screen strings
  static const String reportScreen = 'Tela de Relatório';
  static const String date = 'Data';
  static const String totalProfit = 'Total kit';
  static const String totalExpense = 'Despesa total';
  static const String netProfit = 'Lucro líquido';
  static const String adminProfit = 'Teresa';
  static const String personNetProfit = 'Lucro líquido da pessoa';
}
