import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class PhoneNumberField extends StatefulWidget {
  final TextEditingController _controller;

  const PhoneNumberField({super.key, required controller})
    : _controller = controller;

  @override
  State<PhoneNumberField> createState() => _PhoneNumberFieldState();
}

class _PhoneNumberFieldState extends State<PhoneNumberField> {
  late TextEditingController controller;

  @override
  void initState() {
    controller = widget._controller;
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  final maskFormatter = MaskTextInputFormatter(
    mask: '##-###-##-##',
    filter: {"#": RegExp(r'[0-9]')},
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 280,
      height: 53,
      margin: EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(13),
        border: Border.all(color: Colors.grey.shade600, width: 2),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(width: 15),
          Text(
            ' +998',
            style: TextStyle(
              fontSize: 16,
              color: Color(0xFF0F172A),
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(width: 10),
          Container(
            width: 2,
            height: double.infinity,
            color: Colors.grey.shade600,
          ),
          SizedBox(width: 10),
          Expanded(
            child: TextField(
              controller: controller,
              style: TextStyle(
                fontSize: 16,
                color: Color(0xFF0F172A),
                fontWeight: FontWeight.bold,
              ),
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: "Telefon raqami",
                hintStyle: TextStyle(color: Colors.grey.shade600, fontSize: 15),
              ),
              inputFormatters: [maskFormatter],
            ),
          ),
        ],
      ),
    );
  }
}
