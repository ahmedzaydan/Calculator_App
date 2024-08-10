import 'dart:io';
import 'dart:typed_data';

import 'package:azulzinho/core/utils/functions.dart';
import 'package:azulzinho/features/app_layout/app_layout_cubit/app_states.dart';
import 'package:azulzinho/features/calculator/calculator_cubit/calculator_state.dart';
import 'package:azulzinho/features/kits/kit_cubit/kit_cubit.dart';
import 'package:azulzinho/features/persons/person_cubit/persons_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';

class CalculatorCubit extends Cubit<AppStates> {
  CalculatorCubit(
    this.personsCubit,
    this.kitCubit,
  ) : super(CalculatorInitialState());

  final PersonsCubit personsCubit;
  final KitsCubit kitCubit;

  final TextEditingController expensesController = TextEditingController();
  final TextEditingController extraController = TextEditingController();
  final TextEditingController noteController = TextEditingController();

  String expenses = '';
  String note = '';
  String extra = '';

  double totalExpense = 0.0;
  double totalExtra = 0.0;
  double netProfit = 0.0;

  bool isKitsListCollapsed = false;

  static CalculatorCubit get(context) {
    return BlocProvider.of<CalculatorCubit>(context);
  }

  void toggleKitsListVisibility() {
    isKitsListCollapsed = !isKitsListCollapsed;
    emit(ToggleKitsListVisibilityState());
  }

  double calculateString(String s) {
    double total = 0.0;
    List<String> values = s.split(' ');
    for (var i = 0; i < values.length; i++) {
      if (values[i].isNotEmpty) {
        try {
          total += double.parse(values[i]);
        } catch (e) {
          kprint("\nError Parsing Value: $e\n");
        }
        // klog("\nTotal: $total\n");
      }
    }
    total = formatDobule(total);
    return total;
  }

  void calculate() {
    kitCubit.calculateKits();

    totalExpense = calculateString(expenses);
    totalExtra = calculateString(extra);

    personsCubit.admin.shareValue =
        kitCubit.totalKits * (personsCubit.admin.percentage / 100);
    personsCubit.admin.shareValue = formatDobule(personsCubit.admin.shareValue);

    netProfit = kitCubit.totalKits -
        totalExpense -
        personsCubit.admin.shareValue +
        totalExtra;
    netProfit = formatDobule(netProfit);

    personsCubit.calculatePersonsShareValues(netProfit);

    emit(CalculateState());
  }

  Future<void> clear() async {
    expensesController.clear();
    extraController.clear();
    noteController.clear();

    await kitCubit.clearCheckedKits();

    expenses = '';
    extra = '';
    note = '';
    emit(ClearState());
  }

  Future<void> captureAndShare(ScreenshotController controller) async {
    emit(ShareLoadingState());

    controller.capture().then(
      (capturedImage) {
        // _saveToGallery(capturedImage!);

        _share(capturedImage!);
      },
    ).catchError(
      (onError) {
        kprint("\nError capturing visible image\n");
        kprint("\n${onError.toString()}\n");
      },
    );
  }

  // Future<void> _saveToGallery(Uint8List image) async {
  //   try {
  //     await ImageGallerySaver.saveImage(image);
  //     kprint("File Saved to Gallery\n");
  //   } catch (e) {
  //     kprint("Error Saving File:\n$e");
  //   }
  // }

  void _share(Uint8List image) async {
    try {
      final directory = await getApplicationDocumentsDirectory();

      final imagePath = File('${directory.path}/image.png');

      imagePath.writeAsBytes(image).then((file) {
        Share.shareXFiles([XFile(file.path)]).then((_) {
          emit(ShareSuccessState());
          _deleteImage(file);
        });
      });
    } catch (error) {
      kprint("\nError Sharing Image:\n$error\n");
    }
  }

  Future<void> _deleteImage(File imagePath) async {
    kprint("\nDeleting image.....\n");
    imagePath.delete().then((_) async {
      // test if the image was deleted
      if (await imagePath.exists()) {
        kprint("\nImage Not Deleted\n");
      } else {
        kprint("\nImage Deleted\n");
      }
    }).catchError((error) {
      kprint("\nError Deleting Image:\n$error\n");
    });
  }
}
