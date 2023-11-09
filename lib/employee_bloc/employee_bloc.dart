import 'package:bloc/bloc.dart';
import 'package:hive/hive.dart';
import 'package:meta/meta.dart';
import 'employee_model.dart';

part 'employee_event.dart';
part 'employee_state.dart';

class EmployeeBloc extends Bloc<EmployeeEvent, EmployeeState> {
  final Box<Employee> _employeeBox = Hive.box('employees');
  EmployeeBloc() : super(EmployeeInitial()){
    on<AddEmployeeEvent>((event,emit){
      _employeeBox.add(event.newEmployee);
    });
  }

  @override
  EmployeeState get initialState => EmployeeInitial();

}

