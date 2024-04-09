import 'package:calculator/app/resources/constants_manager.dart';
import 'package:calculator/app/resources/font_manager.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';

void navigateTo({
  required BuildContext context,
  required Widget dest,
}) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => dest,
    ),
  );
}

TextStyle getTextStyle({
  double fontSize = FontSize.s28,
}) {
  return TextStyle(
    fontSize: fontSize,
    color: Colors.black,
  );
}

double formatDobule(double value) {
  return double.parse(value.toStringAsFixed(2));
}

List<TextInputFormatter>? getInputFormatters(String regex) {
  return [
    FilteringTextInputFormatter.allow(RegExp(regex)),
  ];
}

String getCurrentDate() {
  DateTime now = DateTime.now();
  return '${now.day}/${now.month}/${now.year}';
}

Color colorToast(ToastStates state) {
  Color color;
  if (state == ToastStates.success) {
    color = Colors.green;
  } else if (state == ToastStates.error) {
    color = Colors.red;
  } else {
    color = Colors.amber;
  }
  return color;
}

// custom showToast
void showCustomToast(String message, ToastStates state) {
  Fluttertoast.showToast(
    msg: message,
    fontSize: 18,
    timeInSecForIosWeb: 5,
    textColor: Colors.white,
    gravity: ToastGravity.BOTTOM,
    toastLength: Toast.LENGTH_LONG,
    backgroundColor: colorToast(state),
  );
}

TextDirection getTextDirection(String text) {
  if (text.contains(RegExp(r'[a-zA-Z]'))) {
    return TextDirection.ltr;
  } else {
    return TextDirection.rtl;
  }
}

void kprint(dynamic message) {
  if (kDebugMode) {
    print('\n$message\n');
  }
}

String getStateMessage({
  required AppState state,
  required ItemType itemType,
  ItemAction? action,
  String label = '',
  String? error,
}) {
  switch (itemType) {
    case ItemType.kit:
      switch (state) {
        case AppState.loading:
          return 'Loading kits data...';
        case AppState.success:
          switch (action!) {
            case ItemAction.add:
              return '$label added successfully';
            case ItemAction.update:
              return '$label value updated successfully';
            case ItemAction.delete:
              return '$label deleted successfully';
            case ItemAction.load:
              return 'Kits data loaded successfully';
          }
        case AppState.error:
          switch (action!) {
            case ItemAction.add:
              return error ?? 'Failed to add $label';
            case ItemAction.update:
              return 'Failed to update $label value';
            case ItemAction.delete:
              return 'Failed to delete $label';
            case ItemAction.load:
              return 'Failed to load kits data';
          }
      }

    case ItemType.person:
      switch (state) {
        case AppState.loading:
          return 'Loading persons data...';
        case AppState.success:
          switch (action!) {
            case ItemAction.add:
              return '$label added successfully';
            case ItemAction.update:
              return '$label perecentage updated successfully';
            case ItemAction.delete:
              return '$label deleted successfully';
            case ItemAction.load:
              return 'Persons data loaded successfully';
          }
        case AppState.error:
          switch (action!) {
            case ItemAction.add:
              return 'Failed to add $label';
            case ItemAction.update:
              return 'Failed to update $label perecentage';
            case ItemAction.delete:
              return 'Failed to delete $label';
            case ItemAction.load:
              return 'Failed to load persons data';
          }
      }
  }
}
