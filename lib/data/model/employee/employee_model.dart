import '../../../domain/entity/employee/employee_entity.dart';

class EmployeeModel extends EmployeeEntity {
  EmployeeModel.fromJson(Map<String, dynamic> json)
      : super(
          employeeId: json['employee_id'],
          userId: json['user_id'],
          fullName: json['full_name'],
          bornCity: json['born_city'],
          bornDate: json['born_date'],
          citizen: json['citizen'],
          gender: json['gender'],
          maritalStatus: json['marital_status'],
          maritalDate: json['marital_date'],
          religion: json['religion'],
          bloodGroup: json['blood_group'],
          education: json['education'],
          addressFull: json['address_full'],
          addressCity: json['address_city'],
          province: json['province'],
          postalCode: json['postal_code'],
          phoneNo: json['phone_no'],
          handPhoneNo: json['hand_phone_no'],
          bankAccountNo: json['bank_account_no'],
          bankName: json['bank_name'],
          salarySystem: json['salary_system'],
          passportNo: json['passport_no'],
          familyCardNo: json['family_card_no'],
          identityNo: json['identity_no'],
          emergencyNo: json['emergency_no'],
          isDeleted: json['is_deleted'],
        );

  static List<EmployeeEntity> parseEntries(List<dynamic> entries) {
    List<EmployeeEntity> data = [];
    entries.forEach((value) {
      data.add(EmployeeModel.fromJson(value));
    });
    return data;
  }
}
