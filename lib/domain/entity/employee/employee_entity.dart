import 'package:equatable/equatable.dart';

class EmployeeEntity extends Equatable {
  final String employeeId;
  final String userId;
  final String fullName;
  final String bornCity;
  final String bornDate;
  final String citizen;
  final String gender;
  final String maritalStatus;
  final String maritalDate;
  final String religion;
  final String bloodGroup;
  final String education;
  final String addressFull;
  final String addressCity;
  final String province;
  final String postalCode;
  final String phoneNo;
  final String handPhoneNo;
  final String bankAccountNo;
  final String bankName;
  final String salarySystem;
  final String passportNo;
  final String familyCardNo;
  final String identityNo;
  final String emergencyNo;
  final bool isDeleted;

  EmployeeEntity({
    required this.employeeId,
    required this.userId,
    required this.fullName,
    required this.bornCity,
    required this.bornDate,
    required this.citizen,
    required this.gender,
    required this.maritalStatus,
    required this.maritalDate,
    required this.religion,
    required this.bloodGroup,
    required this.education,
    required this.addressFull,
    required this.addressCity,
    required this.province,
    required this.postalCode,
    required this.phoneNo,
    required this.handPhoneNo,
    required this.bankAccountNo,
    required this.bankName,
    required this.salarySystem,
    required this.passportNo,
    required this.familyCardNo,
    required this.identityNo,
    required this.emergencyNo,
    required this.isDeleted,
  });

  @override
  List<Object?> get props => [
        employeeId,
        userId,
        fullName,
        bornCity,
        bornDate,
        citizen,
        gender,
        maritalStatus,
        maritalDate,
        religion,
        bloodGroup,
        education,
        addressFull,
        addressCity,
        province,
        postalCode,
        phoneNo,
        handPhoneNo,
        bankAccountNo,
        bankName,
        salarySystem,
        passportNo,
        familyCardNo,
        identityNo,
        emergencyNo,
        isDeleted,
      ];
}
