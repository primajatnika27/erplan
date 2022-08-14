import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logging/logging.dart';

import '../../../../../core/failure.dart';
import '../../../../../data/model/leave/approval_leave.dart';
import '../../../../../domain/entity/employee/employee_entity.dart';
import '../../../../../domain/entity/leave/leave_entity.dart';
import '../../../../../domain/entity/leave/leave_type_entity.dart';
import '../../../../../domain/repository/leave_repository.dart';
import '../../../../core/app.dart';

abstract class LeaveState extends Equatable {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class LeaveInitialState extends LeaveState {}

class LeaveTypeLoadingState extends LeaveState {
  LeaveTypeLoadingState() : super();
}

class SaveLeaveLoadingState extends LeaveState {
  SaveLeaveLoadingState() : super();
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

class LeaveSaveSuccessState extends LeaveState {
  LeaveSaveSuccessState() : super();
}

class LeaveBloc extends Cubit<LeaveState> {
  final LeaveRepository repository;

  final Logger logger = Logger('EmployeeBloc');
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  ApprovalLeave? approvalLeave;
  EmployeeEntity? approvalHrHeadEntity,
      approvalHrCheckerEntity,
      approvalSpvEntity,
      approvalDirectionEntity,
      replaceEmployeeEntity;

  final TextEditingController leaveTypeController = TextEditingController();
  LeaveTypeEntity? leaveTypeEntity;

  final TextEditingController approvalHrHeadController =
      TextEditingController();

  final TextEditingController approvalHrCheckerController =
      TextEditingController();

  final TextEditingController approvalSpvController = TextEditingController();

  final TextEditingController approvalDirectionController =
      TextEditingController();

  final TextEditingController replaceEmployeeController =
      TextEditingController();

  final TextEditingController leaveFromController = TextEditingController();
  final TextEditingController leaveToController = TextEditingController();
  final TextEditingController returnDateController = TextEditingController();

  final TextEditingController reasonController = TextEditingController();

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

  Future<void> saveLeave() async {
    logger.fine('Save Leave');
    LeaveEntity? entity;

    formKey.currentState!.save();

    if (!formKey.currentState!.validate()) {
      return;
    }

    emit(SaveLeaveLoadingState());

    try {
      entity = LeaveEntity(
        idEmployee: App.main.idUser,
        idReplaceEmployee: replaceEmployeeEntity!.userId,
        idApproval1: approvalSpvEntity!.userId,
        idApproval2: approvalSpvEntity!.userId,
        idApprovalHrd1: approvalHrCheckerEntity!.userId,
        idApprovalHrd2: approvalHrHeadEntity!.userId,
        idApprovalDirection: approvalDirectionEntity!.userId,
        leaveFrom: leaveFromController.text,
        leaveTo: leaveToController.text,
        returnWork: returnDateController.text,
        leaveReason: reasonController.text,
        leaveTypeEntity: leaveTypeEntity!,
      );
    } catch (e) {
      emit(
        LeaveFailedState(code: 500, message: 'Please input mandatory field'),
      );
    }

    Either<Failure, void> result = await repository.saveLeave(entity!);

    LeaveState stateResult = result.fold(
      (failure) {
        logger.warning('Failed data -> $failure');
        RequestFailure f = failure as RequestFailure;
        return LeaveFailedState(code: f.code, message: f.message);
      },
      (s) {
        return LeaveSaveSuccessState();
      },
    );

    emit(stateResult);
  }
}
