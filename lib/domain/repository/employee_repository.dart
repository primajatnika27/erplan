import 'package:dartz/dartz.dart';

import '../../core/failure.dart';
import '../entity/employee/employee_entity.dart';

abstract class EmployeeRepository {
  Future<Either<Failure, List<EmployeeEntity>>> getListEmployee();

  Future<Either<Failure, int>> createEmployee(EmployeeEntity entity);

  Future<Either<Failure, int>> getEmployeeByIdUser(String idUser);
}
