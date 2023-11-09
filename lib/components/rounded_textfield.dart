import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RoundedInputField extends StatelessWidget {
  final String hintText;
  final ValueChanged<String> onChanged;

  RoundedInputField({
    required this.hintText,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: onChanged,
      decoration: InputDecoration(
        hintText: hintText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      ),
    );
  }
}