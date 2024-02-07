import 'package:calculator/core/resources/strings_manager.dart';

class ProfitModel {
  String _id = '';
  double _value = 0.0;
  bool _isChecked = false;

  void setProfitKey(String key) {
    if (key.startsWith('#c')) {
      _id = key.substring(8);
      _isChecked = true;
    } else {
      _id = key.substring(1);
      _isChecked = false;
    }
  }

  // return the key to use in shared preferences
  String getSharedPrefKey() {
    if (_isChecked) {
      return '#checked$_id';
    } else {
      return '#$_id';
    }
  }

  String get id => _id;

  void setValue(double value) => _value = value;

  double get value => _value;

  void toggleStatus() => _isChecked = !_isChecked;

  void setStatus(bool status) => _isChecked = status;

  bool get status => _isChecked;

  String get outputProfitKey {
    String spaces = '    ';
    return '#$_id,$spaces';
  }

  String get checkedId => '#${StringsManager.checked}$_id';

  String get uncheckedId => '#$_id';
}
