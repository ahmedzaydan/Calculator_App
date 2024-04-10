import 'package:calculator/app/utils/functions.dart';
import 'package:calculator/features/kits/kit_cubit/kit_cubit.dart';

class KitModel {
  String name;
  double value;
  bool isChecked;
  DateTime startDate;

  // endDate and status are always non null
  // as they will be assigned in the constructor
  // when calling their methods
  DateTime? endDate;
  KitStatus? status;

  KitModel({
    required this.name,
    required this.value,
    this.isChecked = false,
    required this.startDate,
    this.endDate,
  }) {
    getKitEndDate();
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

  void toggleIsChecked() => isChecked = !isChecked;

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

    DateTime now = getCurrentDate();

    // contract is expired
    if (now.isAfter(endDate!)) {
      status = KitStatus.expired;
    }

    // contract is in the month 30
    else if (now.year == endDate!.year && now.month == endDate!.month) {
      status = KitStatus.month30;
    }

    // contract is in the month 24
    else if (now.year - startDate.year == 2 && startDate.month == now.month) {
      // get the last day of the current month
      int lastDay = DateTime(now.year, now.month + 1, 0).day;

      // if the contract within last 10 days of month 24
      if (now.day >= (lastDay - 10)) {
        status = KitStatus.month24;
      }
      status = KitStatus.month24; // TODO: remove this line
    }

    // contract is in the month 12
    else if (now.year - startDate.year == 1 && now.month == startDate.month) {
      // get the last day of the current month
      int lastDay = DateTime(now.year, now.month + 1, 0).day;

      // if the contract within last 10 days of month 12
      if (now.day >= (lastDay - 10)) {
        status = KitStatus.month12;
      }
      status = KitStatus.month12; // TODO: remove this line
    }
  }

  void getKitEndDate() {
    int futureMonth = startDate.month + 6;

    // contract duration is 2 years and 6 months
    int futureYear = startDate.year + 2;

    // if the future month is greater than 12
    // then the future year will be the next year
    futureYear += (futureMonth ~/ 12);

    // if the future month is greater than 12
    futureMonth %= 12;

    int futureDay = startDate.day - 1;

    // if future day = 0
    if (futureDay == 0) {
      // future day will be the last day of the previous month
      futureDay = DateTime(futureYear, futureMonth, 0).day;

      // future month will be the previous month
      futureMonth -= 1;

      // if the future month is January
      if (futureMonth == 0) {
        // future month will be December
        futureMonth = 12;

        // future year will be the previous year
        futureYear -= 1;
      }
    }

    // if the future day is greater than the last day of the future month
    else if (futureDay > DateTime(futureYear, futureMonth + 1, 0).day) {
      // then the future day will be the last day of future the month
      futureDay = DateTime(futureYear, futureMonth + 1, 0).day;
    }

    endDate = DateTime(futureYear, futureMonth, futureDay);
  }
}
