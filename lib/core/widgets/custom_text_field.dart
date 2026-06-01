import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String hint;
  final TextEditingController controller;
  const CustomTextField({
    super.key,
    required this.hint,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 300,
      child: TextField(
        key: key,
        keyboardType: TextInputType.emailAddress,
        controller: controller,
        style: TextStyle(
          fontSize: 16,
          color: Color(0xFF0F172A),
          fontWeight: FontWeight.bold,
        ),
        decoration: InputDecoration(
          hintText: hint,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
          hintStyle: TextStyle(fontSize: 16, color: Colors.grey.shade600),
        ),
      ),
    );
  }
}
