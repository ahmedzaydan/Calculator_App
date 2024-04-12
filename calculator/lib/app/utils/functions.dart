import 'dart:developer';

import 'package:calculator/app/resources/color_manager.dart';
import 'package:calculator/app/resources/constants_manager.dart';
import 'package:calculator/app/resources/font_manager.dart';
import 'package:calculator/app/resources/strings_manager.dart';
import 'package:calculator/app/resources/styles_manager.dart';
import 'package:calculator/app/widgets/custom_back_arrow.dart';
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

AppBar customAppBar({
  required BuildContext context,
  required String title,
  List<Widget>? actions,
}) {
  return AppBar(
    toolbarHeight: MediaQuery.sizeOf(context).height * 0.09,
    leading: CustomBackArrow(context),
    title: Text(
      title,
      style: TextStylesManager.textStyle24.copyWith(
        color: ColorManager.white,
        fontWeight: FontWeight.bold,
      ),
      softWrap: true,
      maxLines: 3,
      textAlign: TextAlign.center,
    ),
    actions: actions,
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

String getDateAsString({
  DateTime? date,
}) {
  date = date ?? DateTime.now();
  return '${date.day}/${date.month}/${date.year}';
}

DateTime getFormattedDate({
  DateTime? date,
}) {
  date = date ?? DateTime.now();
  return DateTime(
    date.year,
    date.month,
    date.day,
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
  klog('$message\n');
}

void klog(dynamic message) {
  log(message);
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
