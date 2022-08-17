import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:logging/logging.dart';

import '../../config/constant_config.dart';
import '../../core/failure.dart';
import '../../domain/entity/auth/device_entity.dart';
import '../../domain/repository/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final Dio client;
  final String fcmToken;
  final String? accessToken;

  final Logger logger = Logger('AuthRepositoryImpl');

  AuthRepositoryImpl({
    required this.client,
    required this.fcmToken,
    this.accessToken,
  });

  ///LOGIN
  @override
  Future<Either<Failure, List<dynamic>>> login(
      {required String phone,
      required String password,
      String? email,
      String? rePassword}) async {
    logger.fine('Do login => FCM : ${fcmToken}');
    try {
      Response response = await client.post(
        '/auth/login',
        data: {
          'email': phone,
          'password': password,
        },
      );
      logger.fine('Success response => ${response.data}');
      if (response.statusCode == 200) {
        return Right([
          response.data['data']['token'],
          response.data['data']['id'],
          response.data['data']['full_name'],
        ]);
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
  Future<Either<Failure, List>> register({
    required String phone,
    required String password,
    required String rePassword,
    required String email,
    required String organizationCode,
    required DeviceEntity deviceEntity,
  }) async {
    logger.fine('Do login => FCM : ${fcmToken}');
    try {
      Response response = await client.post(
        '/auth/register',
        data: {
          'full_name': phone,
          'username': phone,
          'email': email,
          'password': password,
          'ip_address': deviceEntity.ipAddress,
          'is_logged': true,
          'mac_address': deviceEntity.macAddress,
          'organization_code': organizationCode,

          /// -> Temp HC
          'status': 'active',
        },
      );
      logger.fine('Success response => ${response.data}');
      if (response.statusCode == 201) {
        return Right([
          response.data['data']['token'],
        ]);
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
