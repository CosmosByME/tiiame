import 'package:flutter/material.dart';

class CustomOutlinedButton extends StatelessWidget {
  final double? width;
  final String text;
  final VoidCallback onPressed;
  const CustomOutlinedButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      style: Theme.of(context).outlinedButtonTheme.style!.copyWith(
        minimumSize: WidgetStateProperty.all(Size(width ?? 300, 48)),
      ),
      onPressed: onPressed,
      child: Text(text),
    );
  }
}
