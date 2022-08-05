import 'package:dio/dio.dart';
import 'package:logging/logging.dart';

import '../../core/failure.dart';
import '../../domain/entity/leave/leave_type_entity.dart';
import 'package:dartz/dartz.dart';

import '../../domain/repository/leave_repository.dart';
import '../model/leave/leave_type_model.dart';

class LeaveRepositoryImpl extends LeaveRepository {

  final Dio client;
  final String fcmToken;
  final String? accessToken;

  final Logger logger = Logger('LeaveRepositoryImpl');

  LeaveRepositoryImpl({
    required this.client,
    required this.fcmToken,
    this.accessToken,
  });

  @override
  Future<Either<Failure, List<LeaveTypeEntity>>> getListLeaveType() async {
    logger.fine('Do login => Token : ${accessToken}');
    try {
      Response response = await client.get(
        '/ref/leave-type',
        options: Options(
            headers: {'Authorization': 'Bearer ${this.accessToken}'}
        ),
      );
      logger.fine('Success response => ${response.data}');
      if (response.statusCode == 200) {
        return Right(LeaveTypeModel.parseEntries(response.data['data']));
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