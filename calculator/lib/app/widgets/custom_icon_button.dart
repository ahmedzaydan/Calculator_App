import 'package:flutter/material.dart';

class CustomIconButton extends StatelessWidget {
  const CustomIconButton({
    super.key,
    required this.onPressed,
    required this.icon,
    this.style,
    this.height,
    this.width,
  });

  final void Function()? onPressed;
  final Icon icon;
  final ButtonStyle? style;
  final double? height;
  final double? width;

  @override
  Widget build(BuildContext context) {
    var newWidth = width ?? MediaQuery.sizeOf(context).width * 0.060;
    var newHeight = height ?? MediaQuery.sizeOf(context).height * 0.05;

    return SizedBox(
      width: newWidth,
      height: newHeight,
      child: IconButton(
        alignment: Alignment.center,
        padding: EdgeInsets.zero,
        constraints: BoxConstraints(
          maxWidth: newWidth,
          maxHeight: newHeight,
        ),
        icon: icon,
        onPressed: onPressed,
        style: style ?? Theme.of(context).iconButtonTheme.style,
      ),
    );
  }
}
