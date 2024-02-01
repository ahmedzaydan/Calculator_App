import 'package:calculator/core/resources/constants_manager.dart';
import 'package:flutter/material.dart';

class CustomElevatedButton extends StatelessWidget {
  const CustomElevatedButton({
    super.key,
    required this.onPressed,
    required this.text,
    this.heightValue,
  });

  final void Function()? onPressed;
  final String text;
  final double? heightValue;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.sizeOf(context).height * (heightValue ?? 0.07),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(const Color(0xFF3498db)),
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius:
                  BorderRadius.circular(ConstantsManager.borderRadius),
            ),
          ),
        ),
        child: Text(
          text,
          style: const TextStyle(
            color: Colors.white,
            // color: Colors.black,
            fontSize: 18,
          ),
          textAlign: TextAlign.left,
        ),
      ),
    );
  }
}
