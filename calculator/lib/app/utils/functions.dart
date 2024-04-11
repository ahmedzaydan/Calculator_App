import 'package:calculator/app/resources/color_manager.dart';
import 'package:calculator/app/resources/constants_manager.dart';
import 'package:calculator/app/resources/font_manager.dart';
import 'package:calculator/app/resources/strings_manager.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';

/// UI functions
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

// custom alert dialog
void showCustomDialog({
  required BuildContext context,
  required String message,
  required Function onOk,
}) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        backgroundColor: ColorManager.white,
        actionsAlignment: MainAxisAlignment.spaceBetween,
        content: Text(
          message,
          style: const TextStyle(
            fontSize: FontSize.s24,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              onOk();
              Navigator.pop(context);
            },
            child: const Text(
              StringsManager.delete,
              style: TextStyle(
                color: Colors.red,
                fontSize: FontSize.s20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text(
              StringsManager.cancel,
              style: TextStyle(
                color: Colors.black,
                fontSize: FontSize.s20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      );
    },
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

/// Logic functions
double formatDobule(double value) {
  return double.parse(value.toStringAsFixed(2));
}

List<TextInputFormatter>? getInputFormatters(String regex) {
  return [
    FilteringTextInputFormatter.allow(RegExp(regex)),
  ];
}

String getCurrentDateAsString() {
  DateTime now = DateTime.now();
  return '${now.day}/${now.month}/${now.year}';
}

DateTime getCurrentDate() {
  return DateTime(
    DateTime.now().year,
    DateTime.now().month,
    DateTime.now().day,
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
          return KitsStrings.loadingKits;
        case AppState.success:
          switch (action!) {
            case ItemAction.add:
              return '$label adicionado com sucesso';
            case ItemAction.update:
              return 'Valor $label atualizado com sucesso';
            case ItemAction.delete:
              return '$label excluído com sucesso';
            case ItemAction.load:
              return 'Dados dos kits carregados com sucesso';
          }
        case AppState.error:
          switch (action!) {
            case ItemAction.add:
              return error ?? 'Falha ao adicionar $label';
            case ItemAction.update:
              return 'Falha ao atualizar o valor de $label';
            case ItemAction.delete:
              return 'Falha ao excluir $label';
            case ItemAction.load:
              return 'Falha ao carregar os dados dos kits';
          }
      }

    case ItemType.person:
      switch (state) {
        case AppState.loading:
          return PersonsStrings.loadingPersons;
        case AppState.success:
          switch (action!) {
            case ItemAction.add:
              return '$label adicionado com sucesso';
            case ItemAction.update:
              return 'Porcentagem de $label atualizada com sucesso';
            case ItemAction.delete:
              return '$label excluído com sucesso';
            case ItemAction.load:
              return 'Dados das pessoas carregados com sucesso';
          }
        case AppState.error:
          switch (action!) {
            case ItemAction.add:
              return 'Falha ao adicionar $label';
            case ItemAction.update:
              return 'Falha ao atualizar a porcentagem de $label';
            case ItemAction.delete:
              return 'Falha ao excluir $label';
            case ItemAction.load:
              return 'Falha ao carregar os dados das pessoas';
          }
      }
  }
}
