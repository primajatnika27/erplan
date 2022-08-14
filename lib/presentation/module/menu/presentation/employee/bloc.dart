import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logging/logging.dart';

import '../../../../../core/failure.dart';
import '../../../../../domain/entity/employee/employee_entity.dart';
import '../../../../../domain/repository/employee_repository.dart';

abstract class EmployeeState extends Equatable {
  final List<EmployeeEntity>? employee;

  EmployeeState({this.employee});

  @override
  // TODO: implement props
  List<Object?> get props => [employee];
}

class EmployeeInitialState extends EmployeeState {}

class EmployeeLoadingState extends EmployeeState {
  EmployeeLoadingState({List<EmployeeEntity>? employee})
      : super(employee: employee);
}

class EmployeeFailedState extends EmployeeState {
  final int code;
  final String message;

  EmployeeFailedState({
    required this.code,
    required this.message,
  });

  @override
  List<Object?> get props => [code, message];
}

class EmployeeRegisterGoState extends EmployeeState {
  EmployeeRegisterGoState() : super();
}

class EmployeeSuccessState extends EmployeeState {
  EmployeeSuccessState({List<EmployeeEntity>? employee})
      : super(employee: employee);
}

class EmployeeBloc extends Cubit<EmployeeState> {
  final EmployeeRepository repository;

  final Logger logger = Logger('EmployeeBloc');

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  bool isSearchEmployee = false;
  List<EmployeeEntity>? listEmployee;
  List<EmployeeEntity>? listSearchEmployee;

  TextEditingController identityNumberController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();

  EmployeeBloc({required this.repository}) : super(EmployeeInitialState());

  Future<void> getAllEmployee() async {
    emit(EmployeeLoadingState(employee: state.employee));

    logger.fine('Get All Employee');

    Either<Failure, List<EmployeeEntity>> result =
        await repository.getListEmployee();

    EmployeeState stateResult = result.fold(
      (failure) {
        logger.warning('Failed data -> $failure');
        RequestFailure f = failure as RequestFailure;
        return EmployeeFailedState(code: f.code, message: f.message);
      },
      (s) {
        logger.fine('Success data -> $s');
        listEmployee = s;
        return EmployeeSuccessState(employee: s);
      },
    );

    emit(stateResult);
  }

  Future<void> searchEmployee(String key) async {
    if (key.isNotEmpty) {
      print(key);
      listSearchEmployee = listEmployee
          ?.where((e) => e.fullName.toLowerCase().contains(key.toLowerCase()))
          .toList();
      print('length ${listSearchEmployee!.length}');
      emit(EmployeeSuccessState(employee: listSearchEmployee));
    } else {
      listSearchEmployee = listEmployee;
      emit(EmployeeSuccessState(employee: listSearchEmployee));
    }
  }
}
