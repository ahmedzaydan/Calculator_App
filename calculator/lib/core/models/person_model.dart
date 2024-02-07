import 'package:calculator/core/utils/functions.dart';

class PersonModel {
  String _name = '';
  double _netProfitValue = 0.0;
  double _percentage = 0.0;

  void setName(String name) {
    _name = name;
  }

  String get name => _name;

  void setPercentage(double value) {
    _percentage = value;
  }

  double get percentage => _percentage;

  void calculateNetProfitValue(double totalNetProfit) {
    _netProfitValue = roundDouble(
      totalNetProfit * (_percentage / 100),
    );
  }

  double get netProfitValue => _netProfitValue;
}
