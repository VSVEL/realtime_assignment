part of 'employee_bloc.dart';

@immutable
abstract class EmployeeEvent {}

class AddEmployeeEvent extends EmployeeEvent {
  final Employee newEmployee;

  AddEmployeeEvent(this.newEmployee );
}

