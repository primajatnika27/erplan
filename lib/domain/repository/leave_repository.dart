import 'package:dartz/dartz.dart';

import '../../core/failure.dart';
import '../entity/leave/leave_entity.dart';
import '../entity/leave/leave_type_entity.dart';
import '../entity/leave/list_leave_entity.dart';

abstract class LeaveRepository {
  Future<Either<Failure, List<LeaveTypeEntity>>> getListLeaveType();

  Future<Either<Failure, List<ListLeaveEntity>>> getListLeave();

  Future<Either<Failure, void>> saveLeave(LeaveEntity entity);
}
