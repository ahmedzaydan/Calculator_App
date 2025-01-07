import 'dart:developer';

import 'package:azulzinho/core/utils/constants_manager.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:permission_handler/permission_handler.dart';

void setDeviceType(BuildContext context) {
  double width = MediaQuery.of(context).size.width;
  isTablet = width >= 600;
}

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
  if (kDebugMode) {
    log('$message');
  }
}

Future<void> requestStoragePermission() async {
  var status = await Permission.storage.status;
  if (!status.isGranted) {
    status = await Permission.storage.request();
  }

  // for android 11 and above
  var status2 = await Permission.manageExternalStorage.status;
  if (!status2.isGranted) {
    kprint("Asking for manageExternalStorage permission");
    status2 = await Permission.manageExternalStorage.request();
  }
}
