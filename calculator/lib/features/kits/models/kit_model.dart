import 'package:calculator/features/kits/kit_cubit/kit_cubit.dart';

class KitModel {
  String name;
  double value;
  bool isChecked;
  DateTime startDate;
  DateTime endDate;
  KitStatus? status;

  KitModel({
    required this.name,
    required this.value,
    this.isChecked = false,
    required this.startDate,
    required this.endDate,
    this.status,
  });

  // Constructor that takes list<String> as parameter
  // and assigns the values to the class properties
  KitModel.fromStringList(List<String> data)
      : name = data[0],
        value = double.parse(data[1]),
        isChecked = data[2] == 'true',
        startDate = DateTime.parse(data[3]),
        endDate = DateTime.parse(data[4]);

  void setValue(double val) => value = val;

  void setIsChecked(bool status) => isChecked = status;

  void toggleStatus() => isChecked = !isChecked;

  void setStatus(KitStatus kitStatus) => status = kitStatus;

  String get format {
    String spaces = '  ';
    return '$name,$spaces';
  }

  // Returns a list of strings that represent the class properties
  List<String> toStringList() {
    return [
      name,
      value.toString(),
      isChecked.toString(),
      startDate.toString(),
      endDate.toString(),
    ];
  }
}
