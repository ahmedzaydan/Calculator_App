import 'package:azulzinho/core/resources/strings_manager.dart';
import 'package:azulzinho/themes/color_manager.dart';
import 'package:azulzinho/themes/styles_manager.dart';
import 'package:flutter/material.dart';

void showCustomAlertDialog({
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
          style: getMediumStyle(),
        ),
        actions: [
          // ok button
          TextButton(
            onPressed: () {
              onOk();
              Navigator.pop(context);
            },
            child: Text(
              StringsManager.delete,
              style: getBoldStyle(color: ColorManager.red),
            ),
          ),

          // cancel button
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text(
              StringsManager.cancel,
              style: getBoldStyle(),
            ),
          ),
        ],
      );
    },
  );
}
