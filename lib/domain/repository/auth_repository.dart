import 'package:dartz/dartz.dart';

import '../../core/failure.dart';
import '../entity/auth/device_entity.dart';

abstract class AuthRepository {
  Future<Either<Failure, List<dynamic>>> login({
    required String phone,
    required String password,
  });

  Future<Either<Failure, List<dynamic>>> register({
    required String phone,
    required String password,
    required String rePassword,
    required String email,
    required DeviceEntity deviceEntity,
  });
}
