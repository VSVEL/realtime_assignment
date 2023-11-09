import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CustomDatePickerWidget extends StatefulWidget {
  final Function(DateTime) onSelectedDate;

  CustomDatePickerWidget({required this.onSelectedDate});

  @override
  _CustomDatePickerWidgetState createState() => _CustomDatePickerWidgetState();
}

class _CustomDatePickerWidgetState extends State<CustomDatePickerWidget> {
  late DateTime _selectedDate;
  int _selectedDateIndex = 0;

  @override
  void initState() {
    super.initState();
    _selectedDate = DateTime.now();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Column(
        children: <Widget>[
          GridView.count(
            crossAxisCount: 2,
            shrinkWrap: true,
            children: [
              _buildDateButton('Today', 0),
              _buildDateButton('Next Monday', 1),
              _buildDateButton('Next Tuesday', 2),
              _buildDateButton('After One Week', 3),
            ],
          ),
          CalendarDatePicker(
            initialDate: _selectedDate,
            firstDate: DateTime.now(),
            lastDate: DateTime(2100),
            onDateChanged: (newDate) {
              setState(() {
                _selectedDate = newDate;
              });
            },
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(Icons.calendar_today),
                    SizedBox(width: 8),
                    Text(' ${formattedDate(_selectedDate)}'),
                  ],
                ),
                Row(
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        widget.onSelectedDate(_selectedDate);
                        Navigator.pop(context);
                      },
                      child: Text('Save'),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text('Cancel'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  ElevatedButton _buildDateButton(String label, int index) {
    return ElevatedButton(
      onPressed: () {
        _handleDateButtonPressed(index);
      },
      child: Text(label),
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4.0),
        ),
        padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
        minimumSize: Size(0, 40),
        primary: _selectedDateIndex == index ? Colors.blue : Colors.grey[300],
      ),
    );
  }

  void _handleDateButtonPressed(int index) {
    setState(() {
      _selectedDateIndex = index;
      switch (index) {
        case 0:
          _selectedDate = DateTime.now();
          break;
        case 1:
          _selectedDate = _getNextMonday();
          break;
        case 2:
          _selectedDate = _getNextTuesday();
          break;
        case 3:
          _selectedDate = DateTime.now().add(Duration(days: 7));
          break;
      }
    });
  }

  DateTime _getNextMonday() {
    int daysUntilNextMonday = 1 - DateTime.now().weekday;
    if (daysUntilNextMonday <= 0) {
      daysUntilNextMonday += 7;
    }
    return DateTime.now().add(Duration(days: daysUntilNextMonday));
  }

  DateTime _getNextTuesday() {
    int daysUntilNextTuesday = 2 - DateTime.now().weekday;
    if (daysUntilNextTuesday <= 0) {
      daysUntilNextTuesday += 7;
    }
    return DateTime.now().add(Duration(days: daysUntilNextTuesday));
  }

  String formattedDate(DateTime date) {
    return DateFormat('d MMM y').format(date);
  }
}




