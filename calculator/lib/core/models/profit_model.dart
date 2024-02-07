import 'package:calculator/core/resources/strings_manager.dart';

class ProfitModel {
  String _id;
  double _value;
  bool _isChecked;

  ProfitModel({
    required String id,
    required double value,
    bool isChecked = false,
  })  : _id = id,
        _value = value,
        _isChecked = isChecked;

  void setProfitKey(String key) => _id = key;

  String get id => _id;

  void setValue(double value) => _value = value;

  double get value => _value;

  void toggleStatus() => _isChecked = !_isChecked;

  void setStatus(bool status) => _isChecked = status;

  bool get isChecked => _isChecked;

  String get outputProfitKey {
    String spaces = '    ';
    return '$_id,$spaces';
  }

  String get statusId => '$_id${StringsManager.status}';
}
