import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logging/logging.dart';

import '../../../../../core/failure.dart';
import '../../../../../domain/repository/auth_repository.dart';
import '../../../../core/app.dart';

abstract class AuthLoginState extends Equatable {
  @override
  List<Object?> get props => [];
}

class AuthLoginInitialState extends AuthLoginState {}

class AuthLoginLoadingState extends AuthLoginState {}

class AuthLoginFailedState extends AuthLoginState {
  final int code;
  final String message;

  AuthLoginFailedState({
    required this.code,
    required this.message,
  });

  @override
  List<Object?> get props => [code, message];
}

class AuthLoginSuccessState extends AuthLoginState {
  final String accessToken;

  AuthLoginSuccessState({
    required this.accessToken,
  });

  @override
  List<Object?> get props => [accessToken];
}

class AuthLoginGoState extends AuthLoginState {
  final String accessToken;

  AuthLoginGoState({
    required this.accessToken,
  });

  @override
  List<Object?> get props => [accessToken];
}

class AuthLoginBloc extends Cubit<AuthLoginState> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final AuthRepository repository;

  final Logger logger = Logger('AuthLoginBloc');

  AuthLoginBloc({required this.repository}) : super(AuthLoginInitialState());

  Future<void> signIn() async {
    formKey.currentState!.save();
    if (!formKey.currentState!.validate()) {
      return;
    }

    emit(AuthLoginLoadingState());

    logger.fine(
        'Submit -> username: ${phoneController.text} | password: ${passwordController.text}');

    Either<Failure, List<dynamic>> result = await repository.login(
      phone: phoneController.text,
      password: passwordController.text,
    );

    AuthLoginState stateResult = result.fold(
      (failure) {
        logger.warning('Failed data -> $failure');
        RequestFailure f = failure as RequestFailure;
        return AuthLoginFailedState(code: f.code, message: f.message);
      },
      (s) {
        logger.fine('Success data -> $s');
        App.main.idUser = s[1];
        App.main.username = s[2];
        return AuthLoginGoState(
          accessToken: s[0],
        );
      },
    );

    emit(stateResult);
  }

  void resetForm() {
    formKey.currentState!.reset();
    phoneController.clear();
    passwordController.clear();
  }
}
