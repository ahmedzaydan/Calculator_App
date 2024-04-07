import 'package:flutter/material.dart';

class CustomIconButton extends StatelessWidget {
  const CustomIconButton({
    super.key,
    required this.onPressed,
    required this.icon,
    this.style,
  });

  final void Function()? onPressed;
  final Icon icon;
  final ButtonStyle? style;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.12,
      height: MediaQuery.of(context).size.width * 0.156,
      child: IconButton(
        icon: icon,
        onPressed: onPressed,
        style: style ?? Theme.of(context).iconButtonTheme.style,
      ),
    );
  }
}
