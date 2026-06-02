import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomPasswordField extends StatefulWidget {
  final String hint;
  final TextEditingController controller;
  final int? maxLength;
  const CustomPasswordField({
    super.key,
    required this.hint,
    required this.controller,
    this.maxLength,
  });

  @override
  State<CustomPasswordField> createState() => _CustomPasswordFieldState();
}

class _CustomPasswordFieldState extends State<CustomPasswordField> {
  bool _obscureText = true;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: TextField(
        key: widget.key,
        controller: widget.controller,
        obscureText: _obscureText,
        maxLength: widget.maxLength,
        inputFormatters: widget.maxLength == null
            ? null
            : [LengthLimitingTextInputFormatter(widget.maxLength)],
        style: TextStyle(
          fontSize: 16,
          color: Color(0xFF0F172A),
          fontWeight: FontWeight.bold,
        ),
        decoration: InputDecoration(
          hintText: widget.hint,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
          hintStyle: TextStyle(fontSize: 16, color: Colors.grey.shade600),
          suffixIcon: IconButton(
            icon: Icon(
              _obscureText ? Icons.visibility : Icons.visibility_off,
              color: Colors.grey.shade600,
            ),
            onPressed: () {
              setState(() {
                _obscureText = !_obscureText;
              });
            },
          ),
        ),
      ),
    );
  }
}
