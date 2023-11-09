import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'add_employee.dart';
import 'employee_bloc/employee_bloc.dart';
import 'employee_bloc/employee_model.dart';

class EmployeeList extends StatefulWidget {
  final Box<Employee> employeeBox;

  EmployeeList(this.employeeBox);

  @override
  _EmployeeListState createState() => _EmployeeListState();
}

class _EmployeeListState extends State<EmployeeList> {
  @override
  Widget build(BuildContext context) {
    final employeeBloc = BlocProvider.of<EmployeeBloc>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Employee List'),
      ),
      body: FutureBuilder(
        future: Future.value(widget.employeeBox.isEmpty ?? true),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error occurred: ${snapshot.error}'));
          } else if (snapshot.data == true) {
            return Center(child: Text('No employees added yet.'));
          } else {
            List employees = widget.employeeBox.values.toList();
            return ListView.builder(
              itemCount: employees.length,
              itemBuilder: (context, index) {
                var employee = employees[index];
                return Material(
                  elevation: 4,
                  child: Container(
                    height: 100,
                    width: double.infinity,
                    child: Row(
                      children: [
                        Expanded(
                          child: ListTile(
                            title: Text(employee.name),
                            subtitle: Text(employee.position),

                            // Display other employee details as needed
                          ),
                        ),
                        Expanded(child: Text(employee.joiningDate)),
                        Expanded(child: Text(employee.leavingDate)),
                      ],
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => EmployeeAddForm(employeeBloc)),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}


