import 'package:dartz/dartz.dart';

import '../../core/failure.dart';
import '../entity/approval/list_approval_leave_entity.dart';

abstract class ApprovalRepository {
  Future<Either<Failure, List<ListApprovalLeaveEntity>>> getListLeaveApproval();

  Future<Either<Failure, List<ListApprovalLeaveEntity>>>
      getListReplacementApproval();

  Future<Either<Failure, void>> approval(
    String idApproval,
    String leaveId,
    String employeeId,
    String comment,
  );

  Future<Either<Failure, void>> reject(
    String idApproval,
    String leaveId,
    String employeeId,
    String comment,
  );
}
