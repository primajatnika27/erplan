import 'package:dio/dio.dart';
import 'package:logging/logging.dart';

import '../../core/failure.dart';
import '../../domain/entity/approval/list_approval_leave_entity.dart';
import 'package:dartz/dartz.dart';

import '../../domain/repository/approval_repository.dart';
import '../model/approval/list_approval_leave_model.dart';

class ApprovalRepositoryImpl extends ApprovalRepository {
  final Dio client;
  final String fcmToken;
  final String? accessToken;

  final Logger logger = Logger('LeaveRepositoryImpl');

  ApprovalRepositoryImpl({
    required this.client,
    required this.fcmToken,
    this.accessToken,
  });

  @override
  Future<Either<Failure, List<ListApprovalLeaveEntity>>>
      getListLeaveApproval() async {
    logger.fine('Do login => Token : ${accessToken}');
    try {
      Response response = await client.get(
        '/leave/list/for-approval/pagination',
        options:
            Options(headers: {'Authorization': 'Bearer ${this.accessToken}'}),
      );
      logger.fine('Success response => ${response.data}');
      if (response.statusCode == 200) {
        return Right(
            ListApprovalLeaveModel.parseEntries(response.data['data']));
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
  Future<Either<Failure, List<ListApprovalLeaveEntity>>>
      getListReplacementApproval() async {
    logger.fine('Do login => Token : ${accessToken}');
    try {
      Response response = await client.get(
        '/leave/list/for-replacement/pagination',
        options:
            Options(headers: {'Authorization': 'Bearer ${this.accessToken}'}),
      );
      logger.fine('Success response => ${response.data}');
      if (response.statusCode == 200) {
        return Right(
            ListApprovalLeaveModel.parseEntries(response.data['data']));
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
  Future<Either<Failure, void>> approval(
      String leaveId, String employeeId, String comment) {
    // TODO: implement approval
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, void>> reject(
      String leaveId, String employeeId, String comment) {
    // TODO: implement reject
    throw UnimplementedError();
  }
}
