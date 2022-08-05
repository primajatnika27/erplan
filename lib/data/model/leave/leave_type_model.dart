import 'dart:convert';

import '../../../domain/entity/leave/leave_type_entity.dart';

class LeaveTypeModel extends LeaveTypeEntity {

  LeaveTypeModel.fromJson(Map<String, dynamic> json)
      : super(
          leaveCode: json['leave_code'],
          leaveName: json['leave_name'],
        );

  static List<LeaveTypeEntity> parseEntries(List<dynamic> entries) {
    List<LeaveTypeEntity> data = [];
    entries.forEach((value) {
      data.add(LeaveTypeModel.fromJson(value));
    });
    return data;
  }
}
