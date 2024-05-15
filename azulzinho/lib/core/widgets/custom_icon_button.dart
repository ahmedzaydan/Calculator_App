import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

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
  final FaIcon icon;
  final ButtonStyle? style;
  final double? height;
  final double? width;

  @override
  Widget build(BuildContext context) {
    var newWidth = width?.w ?? 0.054.sw;
    var newHeight = height?.h ?? 0.05.sh;

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
