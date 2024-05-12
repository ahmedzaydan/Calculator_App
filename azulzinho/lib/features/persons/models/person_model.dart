import 'package:azulzinho/app/utils/functions.dart';

class PersonModel {
  int? dbId;
  String name;
  double percentage;
  double shareValue;

  PersonModel({
    this.dbId,
    required this.name,
    required this.percentage,
    this.shareValue = 0.0,
  });


  factory PersonModel.fromMap(Map<String, Object?> data) {
    final dbId = data['id'] as int;
    final name = data['name'] as String;
    final percentage = data['percentage'] as double;

    return PersonModel(
      dbId: dbId,
      name: name,
      percentage: percentage,
    );
  }

  // Constructor that takes list<String> as parameter
  // and assigns the values to the class properties
  PersonModel.fromJson(List<String> data)
      : name = data[0],
        percentage = double.parse(data[1]),
        shareValue = double.parse(data[2]);

  void setPercentage(double value) {
    percentage = value;
  }

  void setDbId(int id) {
    dbId = id;
  }

  int get getDbId => dbId!;

  void calculateShareValue(double totalNetProfit) {
    shareValue = formatDobule(totalNetProfit * (percentage / 100));
  }

  // Returns a list of strings that represent the class properties
  List<String> toStringList() {
    return [
      name,
      percentage.toString(),
      shareValue.toString(),
    ];
  }
}
