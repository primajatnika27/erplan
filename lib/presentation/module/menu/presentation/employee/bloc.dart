import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:logging/logging.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../../core/failure.dart';
import '../../../../../domain/entity/employee/employee_entity.dart';
import '../../../../../domain/repository/employee_repository.dart';
import '../../../../core/app.dart';

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
  TextEditingController fullnameController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController emergencyNumberController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController fullAdressController = TextEditingController();
  TextEditingController provinceController = TextEditingController();
  TextEditingController bankAccountNameController = TextEditingController();
  TextEditingController bankAccountNumberController = TextEditingController();

  EmployeeBloc({required this.repository}) : super(EmployeeInitialState());

  Future<void> createEmployee() async {
    SharedPreferences sp = await Modular.getAsync<SharedPreferences>();
    logger.fine('Save Employee');
    EmployeeEntity? entity;

    formKey.currentState!.save();

    if (!formKey.currentState!.validate()) {
      return;
    }

    emit(EmployeeLoadingState());

    try {
      entity = EmployeeEntity(
        userId: App.main.idUser,
        addressCity: cityController.text,
        addressFull: fullAdressController.text,
        bankAccountNo: bankAccountNumberController.text,
        bankName: bankAccountNameController.text,
        province: provinceController.text,
        emergencyNo: emergencyNumberController.text,
        handPhoneNo: phoneNumberController.text,
        identityNo: identityNumberController.text,
        fullName: fullnameController.text,

        /// HC
        phoneNo: '(022) 7271234',
        bloodGroup: '0',
        bornCity: 'Bandung',
        bornDate: '1999-12-03',
        citizen: 'WNI',
        education: 'S1',
        employeeId: '',
        familyCardNo: '4324211234560001',
        gender: 'P',
        isDeleted: false,
        maritalDate: '2020-04-20',
        maritalStatus: '1',
        passportNo: '123123123123123',
        postalCode: '40287',
        religion: '2',
        salarySystem: 'NOT SET',
      );
    } catch (e) {
      emit(
        EmployeeFailedState(code: 500, message: e.toString()),
      );
    }

    Either<Failure, List<dynamic>> result =
        await repository.createEmployee(entity!);

    EmployeeState stateResult = result.fold(
      (failure) {
        logger.warning('Failed data -> $failure');
        RequestFailure f = failure as RequestFailure;
        return EmployeeFailedState(code: f.code, message: f.message);
      },
      (s) {
        return EmployeeRegisterGoState();
      },
    );

    emit(stateResult);
  }

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
      emit(
        EmployeeSuccessState(employee: listSearchEmployee),
      );
    } else {
      listSearchEmployee = listEmployee;
      emit(
        EmployeeSuccessState(employee: listSearchEmployee),
      );
    }
  }
}
