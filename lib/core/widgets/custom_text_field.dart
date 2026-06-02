import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final double? width;
  final int? maxLines;
  final String hint;
  final TextEditingController controller;
  final bool enabled;
  final TextInputType keyboardType;
  const CustomTextField({
    super.key,
    required this.hint,
    required this.controller,
    this.maxLines,
    this.width,
    this.enabled = true,
    this.keyboardType = TextInputType.text,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? double.infinity,
      child: TextField(
        key: key,
        enabled: enabled,
        readOnly: !enabled,
        keyboardType: keyboardType,
        controller: controller,
        maxLines: maxLines,
        style: TextStyle(
          fontSize: 16,
          color: enabled ? Color(0xFF0F172A) : Color(0xFF475569),
          fontWeight: FontWeight.bold,
        ),
        decoration: InputDecoration(
          hintText: hint,
          filled: true,
          fillColor: enabled ? Colors.white : const Color(0xFFF8FAFC),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
          hintStyle: TextStyle(fontSize: 16, color: Colors.grey.shade600),
        ),
      ),
    );
  }
}
