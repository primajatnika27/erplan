import 'package:equatable/equatable.dart';

import '../../../data/model/leave/list_leave_model.dart';
import '../employee/employee_entity.dart';

class ListLeaveEntity extends Equatable {
  ListLeaveEntity({
    required this.leaveId,
    required this.employeeId,
    required this.employeeLeave,
    required this.leaveDate,
    required this.necessity,
    required this.reason,
    required this.approvalStatus1,
    required this.approvalStatusName1,
    required this.approvalStatus2,
    required this.approvalStatusName2,
    required this.approvalStatus3,
    required this.approvalStatusName3,
    required this.approvalStatus4,
    required this.approvalStatusName4,
    required this.approvalStatus5,
    required this.approvalStatusName5,
    required this.approvalStatusHrd1,
    required this.approvalStatusNameHrd1,
    required this.approvalStatusHrd2,
    required this.approvalStatusNameHrd2,
    required this.commentStatus1,
    required this.commentStatus2,
    required this.commentStatus3,
    required this.commentStatus4,
    required this.commentStatus5,
    required this.commentStatusHrd,
    required this.directBossStatus,
    required this.directBossStatusName,
    required this.lastUpdate,
    required this.submissionTime,
    required this.startTimeLeave,
    required this.endTimeLeave,
    required this.leaveType,
    required this.leavePeriod,
    required this.numberOfDays,
    required this.leaveAddress,
    required this.workDate,
    required this.replacementStatus,
    required this.replacementStatusName,
    required this.handPhoneNo,
    required this.homeTrip,
    required this.departureDate,
    required this.departureRoute,
    required this.returnDate,
    required this.returnRoute,
    required this.linkApproval,
    required this.linkReject,
  });

  final String leaveId;
  final String employeeId;
  final EmployeeForLeave employeeLeave;
  final DateTime leaveDate;
  final String necessity;
  final String reason;
  final String approvalStatus1;
  final String approvalStatusName1;
  final String approvalStatus2;
  final String approvalStatusName2;
  final String approvalStatus3;
  final String approvalStatusName3;
  final String approvalStatus4;
  final String approvalStatusName4;
  final String approvalStatus5;
  final String approvalStatusName5;
  final String approvalStatusHrd1;
  final String approvalStatusNameHrd1;
  final String approvalStatusHrd2;
  final String approvalStatusNameHrd2;
  final String commentStatus1;
  final String commentStatus2;
  final String commentStatus3;
  final String commentStatus4;
  final String commentStatus5;
  final String commentStatusHrd;
  final String directBossStatus;
  final String directBossStatusName;
  final DateTime lastUpdate;
  final DateTime submissionTime;
  final DateTime startTimeLeave;
  final DateTime endTimeLeave;
  final String leaveType;
  final String leavePeriod;
  final int numberOfDays;
  final String leaveAddress;
  final DateTime workDate;
  final String replacementStatus;
  final String replacementStatusName;
  final String handPhoneNo;
  final bool homeTrip;
  final DateTime departureDate;
  final String departureRoute;
  final DateTime returnDate;
  final String returnRoute;
  final String linkApproval;
  final String linkReject;

  @override
  // TODO: implement props
  List<Object?> get props => [
        leaveId,
        employeeId,
        employeeLeave,
        leaveDate,
        necessity,
        reason,
        approvalStatus1,
        approvalStatusName1,
        approvalStatus2,
        approvalStatusName2,
        approvalStatus3,
        approvalStatusName3,
        approvalStatus4,
        approvalStatusName4,
        approvalStatus5,
        approvalStatusName1,
        approvalStatusHrd1,
        approvalStatusNameHrd1,
        approvalStatusHrd2,
        approvalStatusNameHrd2,
        commentStatus1,
        commentStatus2,
        commentStatus3,
        commentStatus4,
        commentStatus5,
        commentStatusHrd,
        directBossStatus,
        directBossStatusName,
        lastUpdate,
        submissionTime,
        startTimeLeave,
        endTimeLeave,
        leaveType,
        leavePeriod,
        numberOfDays,
        leaveAddress,
        workDate,
        replacementStatus,
        replacementStatusName,
        handPhoneNo,
        homeTrip,
        departureDate,
        departureRoute,
        returnDate,
        returnRoute,
        linkApproval,
        linkReject,
      ];
}
