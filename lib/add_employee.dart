import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:realtime_assignment/list_employee.dart';
import 'package:realtime_assignment/components/rounded_textfield.dart';
import 'components/custom_date_picker.dart'; // Import your CustomDatePickerWidget here
import 'components/date_picker.dart';
import 'components/rounded_bottom.dart';
import 'employee_bloc/employee_bloc.dart';
import 'employee_bloc/employee_model.dart';

class EmployeeAddForm extends StatefulWidget {
  final EmployeeBloc employeeBloc; // Accept EmployeeBloc as a parameter

  const EmployeeAddForm(this.employeeBloc);

  @override
  _EmployeeAddFormState createState() => _EmployeeAddFormState();
}

class _EmployeeAddFormState extends State<EmployeeAddForm> {
  late String employeeName;
  late DateTime joiningDate;
  late DateTime leavingDate;
  late List<String> positions;

  String selectedJoiningDateText = '';
  String selectedLeavingDateText = '';
  String selectedPosition = 'Select a position for the employee. ';

  @override
  initState() {
    super.initState();
    employeeName = "";
    joiningDate = DateTime.now();
    leavingDate = DateTime.now();
    positions = [
      "Flutter Developer",
      "Frontend Developer",
      "Backend Developer"
    ];
    String selectedPosition = positions[0];
  }

  Future<void> _selectJoiningDate(BuildContext context) async {
    DateTime? pickedDate = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return CustomDatePickerWidget(
          onSelectedDate: (DateTime selectedDate) {
            setState(() {
              joiningDate = selectedDate;
              selectedJoiningDateText = _formattedDate(selectedDate);
            });
          },
        );
      },
    );
  }

  Future<void> _selectLeavingDate(BuildContext context) async {
    DateTime? pickedDate = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return CustomDatePickerWidget(
          onSelectedDate: (DateTime selectedDate) {
            setState(() {
              joiningDate = selectedDate;
              selectedLeavingDateText = _formattedDate(selectedDate);
            });
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Add Employee")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            RoundedInputField(
              hintText: "Employee Name",
              onChanged: (value) {
                employeeName = value;
              },
            ),
            SizedBox(height: 20),
            ElevatedButton(
                onPressed: () {
                  PositionSelectionBottomSheet.showPositionSelectionBottomSheet(
                      context, positions, (p0) {
                    setState(() {
                      selectedPosition = p0;
                    });
                  });
                },
                child: Text(selectedPosition)),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    onPressed: () async {
                      // Show the CustomDatePickerWidget
                      await _selectJoiningDate(context);
                    },
                    child: Text(selectedJoiningDateText.isNotEmpty
                        ? selectedJoiningDateText // Display selected date if available
                        : _formattedDate(DateTime
                            .now())), // Display current date if not selected
                  ),
                  SizedBox(width: 20),
                  ElevatedButton(
                    onPressed: () async {
                      // Show the CustomDatePickerWidget
                      await _selectLeavingDate(context);
                    },
                    child: Text(selectedLeavingDateText.isNotEmpty
                        ? selectedLeavingDateText // Display selected date if available
                        : _formattedDate(DateTime
                            .now())), // Display current date if not selected
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                final currentContext = context;
                if (employeeName.isNotEmpty && selectedPosition.isNotEmpty) {
                  Box<Employee> employeeBox = Hive.box('employees');
                  Employee newEmployee = Employee(
                    name: employeeName,
                    position: selectedPosition,
                    joiningDate: joiningDate.toString(),
                    leavingDate: leavingDate.toString(),
                  );
                  widget.employeeBloc.add(AddEmployeeEvent(newEmployee));

                  Navigator.pushAndRemoveUntil(
                    currentContext,
                    MaterialPageRoute(
                      builder: (context) => EmployeeList(employeeBox),
                    ),
                    (Route<dynamic> route) => false,
                  );
                } else {
                  // Handle validation or show error message
                }
              },
              child: Text('Add Employee'),
            ),
          ],
        ),
      ),
    );
  }

  String _formattedDate(DateTime date) {
    return DateFormat('d MMM y').format(date);
  }
}
