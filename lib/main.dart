import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'employee_bloc/employee_bloc.dart';
import 'employee_bloc/employee_model.dart';
import 'list_employee.dart';

void main() async {
  // Initialize Hive
  WidgetsFlutterBinding.ensureInitialized();
  final appDocumentDirectory = await path_provider.getApplicationDocumentsDirectory();
  Hive.init(appDocumentDirectory.path);
  await Hive.initFlutter();
  Hive.registerAdapter<Employee>(EmployeeAdapter()); // Assuming Employee is your Hive object
  var employeeBox = await Hive.openBox<Employee>('employees');

  runApp(MyApp(employeeBox));
}

class MyApp extends StatelessWidget {
  final Box<Employee> employeeBox;

  MyApp(this.employeeBox);

  @override
  Widget build(BuildContext context) {
    return  BlocProvider(
        create: (context) => EmployeeBloc(), // Provide the EmployeeBloc here
        child: MaterialApp(
          title: 'Employee App',
          theme: ThemeData(
            primarySwatch: Colors.blue,
            useMaterial3: true,
          ),
          home: EmployeeList(employeeBox),
        ),
      );
  }
}
