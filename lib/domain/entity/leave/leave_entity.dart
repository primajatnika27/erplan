import 'package:equatable/equatable.dart';

import 'leave_type_entity.dart';

class LeaveEntity extends Equatable {
  final String idEmployee;
  final String idApproval1;
  final String idApproval2;
  final String idApprovalHrd1;
  final String idApprovalHrd2;
  final String idApprovalDirection;
  final String idReplaceEmployee;
  final String leaveFrom;
  final String leaveTo;
  final String returnWork;
  final String leaveReason;
  final LeaveTypeEntity leaveTypeEntity;

  LeaveEntity({
    required this.idEmployee,
    required this.idApproval1,
    required this.idApproval2,
    required this.idApprovalHrd1,
    required this.idApprovalHrd2,
    required this.idApprovalDirection,
    required this.idReplaceEmployee,
    required this.leaveFrom,
    required this.leaveTo,
    required this.returnWork,
    required this.leaveReason,
    required this.leaveTypeEntity,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [
        idEmployee,
        idApproval1,
        idApproval2,
        idApprovalHrd1,
        idApprovalHrd2,
        idApprovalDirection,
        idReplaceEmployee,
        leaveFrom,
        leaveTo,
        returnWork,
        leaveReason,
        leaveTypeEntity,
      ];
}
