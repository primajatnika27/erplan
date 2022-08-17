import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logging/logging.dart';

import '../../core/failure.dart';
import '../../domain/entity/department/department_entity.dart';
import '../../domain/repository/department_repository.dart';

abstract class DepartmentState extends Equatable {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class DepartmentInitialState extends DepartmentState {}

class DepartmentLoadingState extends DepartmentState {
  DepartmentLoadingState() : super();
}

class DepartmentFailedState extends DepartmentState {
  final int code;
  final String message;

  DepartmentFailedState({
    required this.code,
    required this.message,
  });

  @override
  List<Object?> get props => [code, message];
}

class DepartmentSuccessState extends DepartmentState {
  final List<DepartmentEntity>? entity;
  DepartmentSuccessState({
    required this.entity,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [entity];
}

class DepartmentBloc extends Cubit<DepartmentState> {
  final DepartmentRepository repository;

  final Logger logger = Logger('DepartmentBloc');

  DepartmentBloc({required this.repository}) : super(DepartmentInitialState());

  Future<void> getDepartment() async {
    emit(DepartmentLoadingState());

    logger.fine('Get List Department');

    Either<Failure, List<DepartmentEntity>> result =
        await repository.getListDepartment();

    DepartmentState stateResult = result.fold(
      (failure) {
        logger.warning('Failed data -> $failure');
        RequestFailure f = failure as RequestFailure;
        return DepartmentFailedState(code: f.code, message: f.message);
      },
      (s) {
        logger.fine('Success data -> $s');
        List<DepartmentEntity> _data = s;
        return DepartmentSuccessState(entity: _data);
      },
    );

    emit(stateResult);
  }
}
