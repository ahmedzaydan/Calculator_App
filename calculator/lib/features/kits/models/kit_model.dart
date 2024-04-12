import 'package:calculator/app/utils/dependency_injection.dart';
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
  String? expiredKey;

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
        endDate = DateTime.parse(data[4]),
        expiredKey = data[5];

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
      expiredKey ?? '',
    ];
  }

  // helper method in deterimining the kit status
  // method return true if the now is in the last 10 days
  // of year 2 or year 1 of the contract
  bool inRange(DateTime date) {
    DateTime now = getFormattedDate();

    // 10 days range start date
    DateTime rangeStart = DateTime(
      date.year,
      date.month,
      date.day - 10,
    );

    // 10 days range end date
    DateTime rangeEnd = DateTime(
      date.year,
      date.month,
      date.day,
    );

    // the 10 days are in the same month
    if (date.day >= 10) {
      // date: 18/5/2023
      // range is from 8 --> 18
      if ((now.month == date.month) &&
          (rangeStart.day <= now.day) &&
          (now.day <= rangeEnd.day)) {
        // now.day = 16 for example
        return true;
      }
    }

    // the 10 days are divided into two months
    else if (date.day < 10) {
      // the two months are in the same year
      // date: 5/5/2023
      // the range is 25/4/2023 --> 5/5/2023
      // now: 28/4/2023 or now: 2/5/2023
      if (date.month > 1) {
        bool condition1 =
            (now.month == rangeStart.month) && (now.day >= rangeStart.day);

        bool condition2 =
            (now.month == rangeEnd.month) && (now.day <= rangeEnd.day);

        if (condition1 || condition2) {
          return true;
        }
      }

      // else tow months are in different years
      // the previous month is in the previous year
      // date: 3/1/2023
      // now.day = 28/12/2022 or 2/1/2023
      else if (date.month == 1) {
        // rangeStart.year == date.year - 1
        // rangeStart.day == date.day
        bool condition1 = (now.year == rangeStart.year) &&
            (now.month == 12) &&
            (now.day >= rangeStart.day);

        // rangeEnd.year == date.year
        // rangeEnd.day == date.day
        bool condition2 = (now.year == rangeEnd.year) &&
            (now.month == 1) &&
            (now.day <= rangeEnd.day);

        if (condition1 || condition2) {
          return true;
        }
      }
    }

    return false;
  }

  void selectStatus() {
    status = KitStatus.normal;

    DateTime now = getFormattedDate();

    // contract is expired
    if (now.isAfter(endDate!)) {
      status = KitStatus.expired;
    }

    // contract is in the month 30
    else if (now.year == endDate!.year && now.month == endDate!.month) {
      status = KitStatus.month30;
    }

    // contract is in the month 24
    else if (now.year - startDate.year == 2) {
      if (inRange(
        DateTime(
          startDate.year + 2,
          startDate.month,
          startDate.day,
        ),
      )) {
        status = KitStatus.month24;
      }
    }

    // contract is in the month 12
    else if (now.year - startDate.year == 1) {
      if (inRange(
        DateTime(
          startDate.year + 1,
          startDate.month,
          startDate.day,
        ),
      )) {
        status = KitStatus.month12;
      }
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

  void fillExpiredKey(int counter) {
    if (status == KitStatus.expired) {
      expiredKey = '${locator<KitsCubit>().expiredKitKeyPrefix}$counter';
    } else {
      expiredKey = '';
    }
  }
}
