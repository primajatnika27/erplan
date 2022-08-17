import 'package:equatable/equatable.dart';

class DepartmentEntity extends Equatable {
  final String departmentCode;
  final String departmentName;

  DepartmentEntity({
    required this.departmentCode,
    required this.departmentName,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [
        departmentCode,
        departmentName,
      ];
}
