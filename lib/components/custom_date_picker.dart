import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CustomDatePicker extends StatelessWidget {
  final DateTime selectedDate;
  final String labelText;
  final Function(BuildContext) onSelectDate;

  CustomDatePicker({
    required this.selectedDate,
    required this.labelText,
    required this.onSelectDate,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: () => onSelectDate(context),
        child: InputDecorator(
          decoration: InputDecoration(
            labelText: labelText,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
            ),
            contentPadding: EdgeInsets.symmetric(horizontal: 20),
          ),
          child: Text(
            DateFormat('d MMM y').format(selectedDate),
            style: TextStyle(fontSize: 16),
          ),
        ),
      ),
    );
  }
}