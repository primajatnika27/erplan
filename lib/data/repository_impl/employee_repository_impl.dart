import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:logging/logging.dart';

import '../../core/failure.dart';
import '../../domain/entity/employee/employee_entity.dart';
import '../../domain/repository/employee_repository.dart';
import '../model/employee/employee_model.dart';

class EmployeeRepositoryImpl extends EmployeeRepository {
  final Dio client;
  final String fcmToken;
  final String? accessToken;

  final Logger logger = Logger('AuthRepositoryImpl');

  EmployeeRepositoryImpl({
    required this.client,
    required this.fcmToken,
    this.accessToken,
  });

  @override
  Future<Either<Failure, List<EmployeeEntity>>> getListEmployee() async {
    logger.fine('Do login => Token : ${accessToken}');
    try {
      Response response = await client.get(
        '/employee/list',
        options:
            Options(headers: {'Authorization': 'Bearer ${this.accessToken}'}),
      );
      logger.fine('Success response => ${response.data}');
      if (response.statusCode == 200) {
        return Right(EmployeeModel.parseEntries(response.data['data']));
      } else {
        return Left(
          RequestFailure(
            code: response.statusCode ?? 500,
            message: (response.data['message'] ??
                    'Something wrong, please try again.')
                .toString()
                .replaceFirst('[', '')
                .replaceAll(']', ''),
          ),
        );
      }
    } catch (e) {
      logger.warning('Error -> $e');
      return Left(
        RequestFailure(
          code: 500,
          message: 'Something wrong, please try again.',
        ),
      );
    }
  }

  @override
  Future<Either<Failure, int>> createEmployee(EmployeeEntity entity) async {
    logger.fine('Do create => Token : ${accessToken}');
    try {
      Response response = await client.post(
        '/employee/',
        data: {
          'user_id': entity.userId,
          'address_city': entity.addressCity,
          'address_full': entity.addressFull,
          'bank_account_no': entity.bankAccountNo,
          'bank_name': entity.bankName,
          'blood_group': entity.bloodGroup,
          'born_city': entity.bornCity,
          'born_date': entity.bornDate,
          'citizen': entity.citizen,
          'education': entity.education,
          'emergency_no': entity.emergencyNo,
          'family_card_no': entity.familyCardNo,
          'full_name': entity.fullName,
          'gender': entity.gender,
          'hand_phone_no': entity.handPhoneNo,
          'identity_no': entity.identityNo,
          'marital_date': entity.maritalDate,
          'marital_status': entity.maritalStatus,
          'passport_no': entity.passportNo,
          'phone_no': entity.phoneNo,
          'postal_code': entity.postalCode,
          'province': entity.province,
          'religion': entity.religion,
          'salary_system': entity.salarySystem,
        },
        options:
            Options(headers: {'Authorization': 'Bearer ${this.accessToken}'}),
      );

      logger.fine('Success response => ${response.data}');
      if (response.statusCode == 201) {
        return Right(response.statusCode!);
      } else {
        return Left(
          RequestFailure(
            code: response.statusCode ?? 500,
            message: (response.data['message'] ??
                    'Something wrong, please try again.')
                .toString()
                .replaceFirst('[', '')
                .replaceAll(']', ''),
          ),
        );
      }
    } catch (e) {
      logger.warning('Error -> $e');
      return Left(
        RequestFailure(
          code: 500,
          message: 'Something wrong, please try again.',
        ),
      );
    }
  }

  @override
  Future<Either<Failure, int>> getEmployeeByIdUser(String idUser) async {
    logger.fine('Do login => Token : ${accessToken}');
    try {
      Response response = await client.get(
        '/employee/by-user-id/$idUser',
        options:
            Options(headers: {'Authorization': 'Bearer ${this.accessToken}'}),
      );
      logger.fine('Success response => ${response.data}');
      if (response.statusCode == 200) {
        return Right(response.statusCode!);
      } else {
        return Left(
          RequestFailure(
            code: response.statusCode ?? 500,
            message: (response.data['message'] ??
                    'Something wrong, please try again.')
                .toString()
                .replaceFirst('[', '')
                .replaceAll(']', ''),
          ),
        );
      }
    } catch (e) {
      logger.warning('Error -> $e');
      return Left(
        RequestFailure(
          code: 500,
          message: 'Something wrong, please try again.',
        ),
      );
    }
  }
}
