import 'package:flutter/material.dart';

class CustomOutlinedButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  const CustomOutlinedButton({
    super.key,
    required this.text,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      style: Theme.of(context).outlinedButtonTheme.style!.copyWith(
        minimumSize: WidgetStateProperty.all(const Size(300, 48)),
      ),
      onPressed: onPressed,
      child: Text(text),
    );
  }
}
