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
  }) {
    selectStatus();
  }

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

  String get format {
    String spaces = '  ';
    return '$name,$spaces';
  }

  // returns a list of strings represent the class properties
  List<String> toStringList() {
    return [
      name,
      value.toString(),
      isChecked.toString(),
      startDate.toString(),
      endDate.toString(),
    ];
  }

  void selectStatus() {
    status = KitStatus.transparent;

    DateTime now = DateTime.now();

    // contract is expired
    if (now.year > endDate.year ||
        (now.year == endDate.year && now.month > endDate.month) ||
        (now.year == endDate.year &&
            now.month == endDate.month &&
            now.day > endDate.day)) {
      status = KitStatus.expired;
    }

    // contract is in the month 30
    else if (now.year == endDate.year && now.month == endDate.month) {
      status = KitStatus.month30;
    }

    // contract is in the month 24
    else if (now.year - startDate.year == 2 && startDate.month == now.month) {
      // get the last day of the current month
      int lastDay = DateTime(now.year, now.month + 1, 0).day;

      // if the contract within last 10 days of month 24
      if ((lastDay >= 30 && now.day >= 20) ||
          (lastDay < 30 && (now.day >= (lastDay - 10)))) {
        status = KitStatus.month24;
      }
      status = KitStatus.month24; // TODO: remove this line
    }

    // contract is in the month 12
    else if (now.year - startDate.year == 1 && now.month == startDate.month) {
      // get the last day of the current month
      int lastDay = DateTime(now.year, now.month + 1, 0).day;

      // if the contract within last 10 days of month 12
      if ((lastDay >= 30 && now.day >= 20) ||
          (lastDay < 30 && (now.day >= (lastDay - 10)))) {
        status = KitStatus.month12;
      }
      status = KitStatus.month12; // TODO: remove this line
    }
  }
}
