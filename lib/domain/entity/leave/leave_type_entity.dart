import 'package:equatable/equatable.dart';

class LeaveTypeEntity extends Equatable {
  final String leaveCode;
  final String leaveName;

  LeaveTypeEntity({
    required this.leaveCode,
    required this.leaveName,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [
    leaveCode,
    leaveName,
  ];
}