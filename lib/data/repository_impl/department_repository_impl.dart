import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:logging/logging.dart';

import '../../core/failure.dart';
import '../../domain/entity/department/department_entity.dart';
import '../../domain/repository/department_repository.dart';
import '../model/department/department_model.dart';

class DepartmentRepositoryImpl extends DepartmentRepository {
  final Dio client;
  final String fcmToken;
  final String? accessToken;

  final Logger logger = Logger('DepartmenteRepositoryImpl');

  DepartmentRepositoryImpl({
    required this.client,
    required this.fcmToken,
    this.accessToken,
  });

  @override
  Future<Either<Failure, List<DepartmentEntity>>> getListDepartment() async {
    try {
      Response response = await client.get(
        '/api/ref/department',
        options: Options(headers: {
          'Authorization':
              'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyX2lkIjoiYmViYjE0MzQtMDQ0Ny00MmM0LTk3NDMtNTgyYTc3Y2I1NzYwIiwiZXhwIjoxNjg4MjU5NzIxLCJpYXQiOjE2NTY3MjM3MjEsImlzcyI6ImFkbWluIn0.wGH_g314kzUgPL2FswS_fNqbq_BO47zXdH5cnCH_SJI'
        }),
      );
      logger.fine('Success response => ${response.data}');
      if (response.statusCode == 200) {
        return Right(DepartmentModel.parseEntries(response.data['data']));
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
