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
        options: Options(
          headers: {'Authorization': 'Bearer ${this.accessToken}'}
        ),
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


}