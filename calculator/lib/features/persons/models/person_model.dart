import 'package:calculator/app/utils/functions.dart';

class PersonModel {
  String name;
  double percentage;
  double shareValue;

  PersonModel({
    required this.name,
    required this.percentage,
    this.shareValue = 0.0,
  });

  // Constructor that takes list<String> as parameter
  // and assigns the values to the class properties
  PersonModel.fromJson(List<String> data)
      : name = data[0],
        percentage = double.parse(data[1]),
        shareValue = double.parse(data[2]);

  void setPercentage(double value) {
    percentage = value;
  }

  void calculateShareValue(double totalNetProfit) {
    shareValue = roundDouble(totalNetProfit * (percentage / 100));
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
