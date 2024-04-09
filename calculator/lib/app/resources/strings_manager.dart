abstract class StringsManager {
  // general strings
  static const String emptyString = '';
  static const String loading = 'Loading...';
  static const String dataLoadingError =
      'An error occurred while loading data, please try again later';

  // Calculator screen
  static const String calculatorScreen = 'Calculator';
  static const String kits = 'Kits';
  static const String expenses = 'Expenses';
  static const expansesHint = 'value1,  value2,';
  static const String extra = 'Extra';
  static const String note = 'Note';
  static const String clear = 'Clear';
  static const String calculate = 'Calculate';

  static const String name = 'Name';
  static const String enterName = 'Enter name';

  // persons screen
  static const String personsScreen = 'Persons Screen';
  static const String editPersons =
      'Edit Persons'; // TODO: delete unused strings
  static const String add = 'Add';
  static const String addPerson = 'Add New Person';
  static const String percentage = 'Percentage';
  static const String enterPercentage = 'Enter percentage';
  static const String personExists = 'Person name already exists';
  static const String percentageError =
      'Total percentage must be less than 100';
  static const String invalidPercentage =
      'Percentage must be a number between 0 and 100';

  // settings screen strings
  static const String settings = 'Settings';
  static const String adminPercentage = 'Teresa';
  static const String save = 'Save';
  static const String editKits = 'Edit Kits';

  // kits screen
  static const String kitsScreen = 'Kits Screen';
  static const String editKitList = 'Edit Kit List';
  static const String kitNumber = 'Kit number';
  static const String kitValue = 'Kit value';
  static const String enterValue = 'Enter value';
  static const String enterNumber = 'Enter kit number';
  static const String kitExists = 'Kit id already exists';
  static const String invalidProfitId = 'Kit number must be an integer';
  static const String addKit = 'Add New Kit';
  static const String month12 = '1° reajuste';
  static const String month24 = '2° reajuste';
  static const String month30 = 'RENOVAR';
  // TODO: what is the correct string value in portuguese
  static const String expired = 'Expired';
  static const String pickMeAColour = 'Pick me a colour';

  // output screen strings
  static const String reportScreen = 'Report Screen';
  static const String date = 'Date';
  static const String totalProfit = 'Total kit';
  static const String totalExpense = 'Total expense';
  static const String netProfit = 'Net profit';
  static const String adminProfit = 'Teresa';
  static const String personNetProfit = 'Person net kit';

  // cubit strings
  static const String status = 'status';
  static const String admin = 'Teresa';
  static const String defaultError = 'An error occurred';
}
