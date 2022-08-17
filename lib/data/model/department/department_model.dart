import 'dart:convert';

import '../../../domain/entity/department/department_entity.dart';
import '../../../domain/entity/leave/leave_type_entity.dart';

class DepartmentModel extends DepartmentEntity {
  DepartmentModel.fromJson(Map<String, dynamic> json)
      : super(
          departmentCode: json['department_code'],
          departmentName: json['department_name'],
        );

  static List<DepartmentEntity> parseEntries(List<dynamic> entries) {
    List<DepartmentEntity> data = [];
    entries.forEach((value) {
      data.add(DepartmentModel.fromJson(value));
    });
    return data;
  }
}
