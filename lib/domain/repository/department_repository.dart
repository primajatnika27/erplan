import 'package:dartz/dartz.dart';

import '../../core/failure.dart';
import '../entity/department/department_entity.dart';

abstract class DepartmentRepository {
  Future<Either<Failure, List<DepartmentEntity>>> getListDepartment();
}
