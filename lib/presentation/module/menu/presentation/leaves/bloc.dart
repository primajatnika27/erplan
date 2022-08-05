import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logging/logging.dart';

import '../../../../../core/failure.dart';
import '../../../../../domain/entity/leave/leave_type_entity.dart';
import '../../../../../domain/repository/leave_repository.dart';

abstract class LeaveState extends Equatable {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class LeaveInitialState extends LeaveState {}

class LeaveTypeLoadingState extends LeaveState {
  LeaveTypeLoadingState() : super();
}

class LeaveFailedState extends LeaveState {
  final int code;
  final String message;

  LeaveFailedState({
    required this.code,
    required this.message,
  });

  @override
  List<Object?> get props => [code, message];
}

class LeaveTypeSuccessState extends LeaveState {
  final List<LeaveTypeEntity>? entity;
  LeaveTypeSuccessState({
    required this.entity,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [entity];
}

class LeaveBloc extends Cubit<LeaveState> {
  final LeaveRepository repository;

  final Logger logger = Logger('EmployeeBloc');

  final TextEditingController leaveTypeController = TextEditingController();

  LeaveBloc({required this.repository}) : super(LeaveInitialState());

  Future<void> getLeaveType() async {
    emit(LeaveTypeLoadingState());

    logger.fine('Get Leave Type');

    Either<Failure, List<LeaveTypeEntity>> result =
        await repository.getListLeaveType();

    LeaveState stateResult = result.fold(
      (failure) {
        logger.warning('Failed data -> $failure');
        RequestFailure f = failure as RequestFailure;
        return LeaveFailedState(code: f.code, message: f.message);
      },
      (s) {
        logger.fine('Success data -> $s');
        List<LeaveTypeEntity> _data = s;
        return LeaveTypeSuccessState(entity: _data);
      },
    );

    emit(stateResult);
  }
}
