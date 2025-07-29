import 'package:flutter/material.dart';

class CustomFormField extends StatelessWidget {
  final FormFieldValidator<String?>? validator;
  String hint;
  TextEditingController? controller;
  bool secureText;
  TextInputType KeyboardType;
  int lines;
  CustomFormField(
      {required this.hint,
      this.KeyboardType = TextInputType.text,
      this.secureText = false,
      this.validator,
      this.controller,
      this.lines = 1});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLines: lines,
      controller: controller,
      validator: validator,
      obscureText: secureText,
      keyboardType: KeyboardType,
      decoration: InputDecoration(
        labelText: hint,
      ),
    );
  }
}
