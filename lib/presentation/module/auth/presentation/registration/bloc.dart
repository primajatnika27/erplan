import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logging/logging.dart';

import '../../../../../core/failure.dart';
import '../../../../../domain/entity/auth/device_entity.dart';
import '../../../../../domain/entity/department/department_entity.dart';
import '../../../../../domain/repository/auth_repository.dart';
import '../../../../../helper/string_helper.dart';

abstract class AuthRegisterState extends Equatable {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class AuthRegisterInitialState extends AuthRegisterState {}

class AuthRegisterLoadingState extends AuthRegisterState {}

class AuthRegisterFailedState extends AuthRegisterState {
  final int code;
  final String message;

  AuthRegisterFailedState({
    required this.code,
    required this.message,
  });

  @override
  List<Object?> get props => [code, message];
}

class AuthRegisterSuccessState extends AuthRegisterState {
  final String accessToken;

  AuthRegisterSuccessState({
    required this.accessToken,
  });

  @override
  List<Object?> get props => [accessToken];
}

class AuthRegisterGoState extends AuthRegisterState {
  final String accessToken;

  AuthRegisterGoState({
    required this.accessToken,
  });

  @override
  List<Object?> get props => [accessToken];
}

class AuthRegisterBloc extends Cubit<AuthRegisterState> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final TextEditingController usernameController = TextEditingController();
  final TextEditingController fullnameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController rePasswordController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  final TextEditingController departmentController = TextEditingController();
  DepartmentEntity? departmentEntity;

  final AuthRepository repository;

  final Logger logger = Logger('AuthRegisterBloc');

  AuthRegisterBloc({required this.repository})
      : super(AuthRegisterInitialState());

  Future<void> register() async {
    formKey.currentState!.save();
    if (!formKey.currentState!.validate()) {
      return;
    }

    emit(AuthRegisterLoadingState());

    if (passwordController.text != rePasswordController.text) {
      emit(
        AuthRegisterFailedState(
          code: 500,
          message: 'Password and confirmation password do not match',
        ),
      );
      return;
    }

    if (passwordController.text.length < 6 &&
        rePasswordController.text.length < 6) {
      emit(
        AuthRegisterFailedState(
          code: 500,
          message: 'Min password length 6',
        ),
      );
      return;
    }

    final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();

    String _macAddress = '';
    String _ipAddress = '';

    if (Platform.isAndroid) {
      AndroidDeviceInfo _deviceInfo = await deviceInfoPlugin.androidInfo;
      _macAddress = '0-0-0-0-0-0';
      _ipAddress = await StringHelper.getPublicIP();
    } else if (Platform.isIOS) {
      IosDeviceInfo _deviceInfo = await deviceInfoPlugin.iosInfo;
      _macAddress = '0-0-0-0-0-0';
      _ipAddress = await StringHelper.getPublicIP();
    }

    logger.fine(
        'Submit -> username: ${usernameController.text} | password: ${passwordController.text} | email: ${emailController.text}');

    Either<Failure, List<dynamic>> result = await repository.register(
      fullname: fullnameController.text,
      phone: usernameController.text,
      password: passwordController.text,
      rePassword: rePasswordController.text,
      email: emailController.text,
      deviceEntity: DeviceEntity(
        macAddress: _macAddress,
        ipAddress: _ipAddress,
      ),
      organizationCode: departmentEntity!.departmentCode,
    );

    AuthRegisterState stateResult = result.fold(
      (failure) {
        logger.warning('Failed data -> $failure');
        RequestFailure f = failure as RequestFailure;
        return AuthRegisterFailedState(code: f.code, message: f.message);
      },
      (s) {
        logger.fine('Success data -> $s');
        return AuthRegisterGoState(
          accessToken: s[0],
        );
      },
    );

    emit(stateResult);
  }

  void resetForm() {
    formKey.currentState!.reset();
    usernameController.clear();
    passwordController.clear();
    rePasswordController.clear();
    emailController.clear();
  }
}
