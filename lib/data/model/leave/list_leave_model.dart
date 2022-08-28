import '../../../domain/entity/leave/list_leave_entity.dart';
import '../employee/employee_model.dart';

class ListLeaveModel extends ListLeaveEntity {
  ListLeaveModel.fromJson(Map<String, dynamic> json)
      : super(
          leaveId: json["leave_id"] == null ? null : json["leave_id"],
          employeeId: json["employee_id"] == null ? null : json["employee_id"],
          employeeLeave: EmployeeForLeave.fromJson(json["employee_leave"]),
          leaveDate: DateTime.parse(json["leave_date"]),
          necessity: json["necessity"] == null ? null : json["necessity"],
          reason: json["reason"] == null ? null : json["reason"],
          approvalStatus1: json["approval_status_1"] == null
              ? null
              : json["approval_status_1"],
          approvalStatusName1: json["approval_status_name_1"] == null
              ? null
              : json["approval_status_name_1"],
          approvalStatus2: json["approval_status_2"] == null
              ? null
              : json["approval_status_2"],
          approvalStatusName2: json["approval_status_name_2"] == null
              ? null
              : json["approval_status_name_2"],
          approvalStatus3: json["approval_status_3"] == null
              ? null
              : json["approval_status_3"],
          approvalStatusName3: json["approval_status_name_3"] == null
              ? null
              : json["approval_status_name_3"],
          approvalStatus4: json["approval_status_4"] == null
              ? null
              : json["approval_status_4"],
          approvalStatusName4: json["approval_status_name_4"] == null
              ? null
              : json["approval_status_name_4"],
          approvalStatus5: json["approval_status_5"] == null
              ? null
              : json["approval_status_5"],
          approvalStatusName5: json["approval_status_name_5"] == null
              ? null
              : json["approval_status_name_5"],
          approvalStatusHrd1: json["approval_status_hrd_1"] == null
              ? null
              : json["approval_status_hrd_1"],
          approvalStatusNameHrd1: json["approval_status_name_hrd_1"] == null
              ? null
              : json["approval_status_name_hrd_1"],
          approvalStatusHrd2: json["approval_status_hrd_2"] == null
              ? null
              : json["approval_status_hrd_2"],
          approvalStatusNameHrd2: json["approval_status_name_hrd_2"] == null
              ? null
              : json["approval_status_name_hrd_2"],
          commentStatus1: json["comment_status_1"] == null
              ? null
              : json["comment_status_1"],
          commentStatus2: json["comment_status_2"] == null
              ? null
              : json["comment_status_2"],
          commentStatus3: json["comment_status_3"] == null
              ? null
              : json["comment_status_3"],
          commentStatus4: json["comment_status_4"] == null
              ? null
              : json["comment_status_4"],
          commentStatus5: json["comment_status_5"] == null
              ? null
              : json["comment_status_5"],
          commentStatusHrd: json["comment_status_hrd"] == null
              ? null
              : json["comment_status_hrd"],
          directBossStatus: json["direct_boss_status"] == null
              ? null
              : json["direct_boss_status"],
          directBossStatusName: json["direct_boss_status_name"] == null
              ? null
              : json["direct_boss_status_name"],
          lastUpdate: DateTime.parse(json["last_update"]),
          submissionTime: DateTime.parse(json["submission_time"]),
          startTimeLeave: DateTime.parse(json["start_time_leave"]),
          endTimeLeave: DateTime.parse(json["end_time_leave"]),
          leaveType: json["leave_type"] == null ? null : json["leave_type"],
          leavePeriod:
              json["leave_period"] == null ? null : json["leave_period"],
          numberOfDays:
              json["number_of_days"] == null ? null : json["number_of_days"],
          leaveAddress:
              json["leave_address"] == null ? null : json["leave_address"],
          workDate: DateTime.parse(json["work_date"]),
          replacementStatus: json["replacement_status"] == null
              ? null
              : json["replacement_status"],
          replacementStatusName: json["replacement_status_name"] == null
              ? null
              : json["replacement_status_name"],
          handPhoneNo:
              json["hand_phone_no"] == null ? null : json["hand_phone_no"],
          homeTrip: json["home_trip"] == null ? null : json["home_trip"],
          departureDate: DateTime.parse(json["departure_date"]),
          departureRoute:
              json["departure_route"] == null ? null : json["departure_route"],
          returnDate: DateTime.parse(json["return_date"]),
          returnRoute:
              json["return_route"] == null ? null : json["return_route"],
          linkApproval:
              json["link_approval"] == null ? null : json["link_approval"],
          linkReject: json["link_reject"] == null ? null : json["link_reject"],
        );

  static List<ListLeaveEntity> parseEntries(List<dynamic> entries) {
    List<ListLeaveEntity> data = [];
    entries.forEach((value) {
      data.add(ListLeaveModel.fromJson(value));
    });
    return data;
  }
}

class EmployeeForLeave {
  EmployeeForLeave({
    required this.employeeId,
    required this.fullName,
    required this.phoneNo,
    required this.handPhoneNo,
  });

  String employeeId;
  String fullName;
  String phoneNo;
  String handPhoneNo;

  factory EmployeeForLeave.fromJson(Map<String, dynamic> json) =>
      EmployeeForLeave(
        employeeId: json["employee_id"] == null ? null : json["employee_id"],
        fullName: json["full_name"] == null ? null : json["full_name"],
        phoneNo: json["phone_no"] == null ? null : json["phone_no"],
        handPhoneNo:
            json["hand_phone_no"] == null ? null : json["hand_phone_no"],
      );

  Map<String, dynamic> toJson() => {
        "employee_id": employeeId == null ? null : employeeId,
        "full_name": fullName == null ? null : fullName,
        "phone_no": phoneNo == null ? null : phoneNo,
        "hand_phone_no": handPhoneNo == null ? null : handPhoneNo,
      };
}
