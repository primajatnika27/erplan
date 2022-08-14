import 'package:dio/dio.dart';
import 'package:logging/logging.dart';

import '../../core/failure.dart';
import '../../domain/entity/leave/leave_entity.dart';
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
        options:
            Options(headers: {'Authorization': 'Bearer ${this.accessToken}'}),
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

  @override
  Future<Either<Failure, void>> saveLeave(LeaveEntity entity) async {
    logger.fine('Do login => Token : ${accessToken}');
    try {
      Response response = await client.post(
        '/leave/',
        options:
            Options(headers: {'Authorization': 'Bearer ${this.accessToken}'}),
        data: {
          "employee": {
            "id": entity.idEmployee,
          },
          "approval_1": {
            "id": entity.idApproval1,
          },
          "approval_2": {
            "id": "291f1bc1-06a2-44e6-955e-760ecbc3a781",
          },
          "approval_hrd_1": {
            "id": entity.idApprovalHrd1,
          },
          "approval_hrd_2": {
            "id": entity.idApprovalHrd2,
          },
          "direct_boss": {
            "id": entity.idApprovalDirection,
          },
          "approval_status_1": "0",
          "approval_status_2": "0",
          "approval_status_hrd_1": "0",
          "approval_status_hrd_2": "0",
          "direct_boss_status": "0",
          "comment_status_1": "",
          "comment_status_2": "",
          "comment_status_3": "",
          "comment_status_4": "",
          "comment_status_5": "",
          "comment_status_hrd_1": "",
          "comment_status_hrd_2": "",
          "departure_date": "2022-06-05",
          "departure_route": "",
          "end_time_leave": entity.leaveTo,
          "hand_phone_no": "085875074351",
          "is_home_trip": false,
          "leave_address": "Bandung, Jawa Barat",
          "leave_date": entity.leaveFrom,
          "leave_period": "01",
          "leave_type": entity.leaveTypeEntity.leaveCode,
          "necessity": entity.leaveTypeEntity.leaveName,
          "number_of_days": 2,
          "reason": entity.leaveReason,
          "replacement_employee": {
            "id": entity.idReplaceEmployee,
          },
          "replacement_status": "1",
          "return_date": entity.returnWork,
          "return_route": "",
          "start_time_leave": entity.leaveFrom,
          "work_date": entity.returnWork
        },
      );
      logger.fine('Success response => ${response.data}');
      if (response.statusCode == 201) {
        return Right(response.data);
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
