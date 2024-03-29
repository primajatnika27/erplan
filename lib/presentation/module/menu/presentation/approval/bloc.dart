import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logging/logging.dart';

import '../../../../../core/failure.dart';
import '../../../../../domain/entity/approval/list_approval_leave_entity.dart';
import '../../../../../domain/repository/approval_repository.dart';

abstract class ApprovalState extends Equatable {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class ApprovalInitialState extends ApprovalState {}

class ApprovalLoadingState extends ApprovalState {
  ApprovalLoadingState() : super();
}

class ApprovalFailedState extends ApprovalState {
  final int code;
  final String message;

  ApprovalFailedState({
    required this.code,
    required this.message,
  });

  @override
  List<Object?> get props => [code, message];
}

class ApprovalLeaveListSuccessState extends ApprovalState {
  final List<ListApprovalLeaveEntity>? entity;
  ApprovalLeaveListSuccessState({
    required this.entity,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [entity];
}

class ApprovalReplacementListSuccessState extends ApprovalState {
  final List<ListApprovalLeaveEntity>? entity;
  ApprovalReplacementListSuccessState({
    required this.entity,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [entity];
}

class ApprovalSuccessState extends ApprovalState {
  ApprovalSuccessState();
}

class ApprovalBloc extends Cubit<ApprovalState> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController commentController = TextEditingController();

  final ApprovalRepository repository;

  final Logger logger = Logger('ApprovalBloc');

  ApprovalBloc({required this.repository}) : super(ApprovalInitialState());

  Future<void> getListApprovalLeave() async {
    logger.fine('Get List Approval');

    Either<Failure, List<ListApprovalLeaveEntity>> result =
        await repository.getListLeaveApproval();

    ApprovalState stateResult = result.fold(
      (failure) {
        logger.warning('Failed data -> $failure');
        RequestFailure f = failure as RequestFailure;
        return ApprovalFailedState(code: f.code, message: f.message);
      },
      (s) {
        logger.fine('Success data -> $s');
        return ApprovalLeaveListSuccessState(entity: s);
      },
    );

    emit(stateResult);
  }

  Future<void> getListApprovalReplacement() async {
    logger.fine('Get List Approval Replacement');

    Either<Failure, List<ListApprovalLeaveEntity>> result =
        await repository.getListReplacementApproval();

    ApprovalState stateResult = result.fold(
      (failure) {
        logger.warning('Failed data -> $failure');
        RequestFailure f = failure as RequestFailure;
        return ApprovalFailedState(code: f.code, message: f.message);
      },
      (s) {
        logger.fine('Success data -> $s');
        return ApprovalReplacementListSuccessState(entity: s);
      },
    );

    emit(stateResult);
  }

  Future<void> updateToApproval(
      String approvalId, String leaveId, String employeeId) async {
    formKey.currentState!.save();
    if (!formKey.currentState!.validate()) {
      return;
    }

    emit(ApprovalLoadingState());

    logger.fine('Update to Approval');

    Either<Failure, void> result = await repository.approval(
        approvalId, leaveId, employeeId, commentController.text);

    ApprovalState stateResult = result.fold(
      (failure) {
        logger.warning('Failed data -> $failure');
        RequestFailure f = failure as RequestFailure;
        return ApprovalFailedState(code: f.code, message: f.message);
      },
      (s) {
        return ApprovalSuccessState();
      },
    );

    emit(stateResult);
  }

  Future<void> updateToReject(
      String approvalId, String leaveId, String employeeId) async {
    formKey.currentState!.save();
    if (!formKey.currentState!.validate()) {
      return;
    }

    emit(ApprovalLoadingState());

    logger.fine('Update to Reject');

    Either<Failure, void> result = await repository.reject(
        approvalId, leaveId, employeeId, commentController.text);

    ApprovalState stateResult = result.fold(
      (failure) {
        logger.warning('Failed data -> $failure');
        RequestFailure f = failure as RequestFailure;
        return ApprovalFailedState(code: f.code, message: f.message);
      },
      (s) {
        return ApprovalSuccessState();
      },
    );

    emit(stateResult);
  }
}
