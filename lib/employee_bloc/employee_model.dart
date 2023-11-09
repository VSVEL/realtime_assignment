import 'package:hive/hive.dart';

part 'employee_model.g.dart';

@HiveType(typeId: 0)
class Employee {
  @HiveField(0)
  late String name;

  @HiveField(1)
  late String position;

  @HiveField(2)
  late String joiningDate;

  @HiveField(3)
  late String leavingDate;

  Employee(
      {required this.name,
      required this.position,
      required this.joiningDate,
      required this.leavingDate});
}
