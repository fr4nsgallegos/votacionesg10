import 'package:flutter/material.dart';

class FieldBox extends StatelessWidget {
  String title;
  String hint;
  bool isPassword;
  TextEditingController controller;

  FieldBox(
      {required this.title,
      required this.hint,
      this.isPassword = false,
      required this.controller});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24),
      child: TextField(
        controller: controller,
        obscureText: isPassword,
        cursorColor: Colors.orange,
        style: TextStyle(fontWeight: FontWeight.bold),
        decoration: InputDecoration(
          labelText: title,
          hintText: hint,
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.orange),
          ),
        ),
      ),
    );
  }
}
