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
  bool isAlreadyregisterEmployee = false;
  List<EmployeeEntity>? listEmployee;
  List<EmployeeEntity>? listSearchEmployee;

  TextEditingController identityNumberController = TextEditingController();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController homeNumberController = TextEditingController();
  TextEditingController emergencyNumberController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController fullAdressController = TextEditingController();
  TextEditingController provinceController = TextEditingController();
  TextEditingController bloodGroupController = TextEditingController();
  TextEditingController bornCityController = TextEditingController();
  TextEditingController bornDateController = TextEditingController();
  TextEditingController citizenController = TextEditingController();
  TextEditingController educationController = TextEditingController();
  TextEditingController familyCardNoController = TextEditingController();
  TextEditingController genderController = TextEditingController();
  TextEditingController passportNoController = TextEditingController();
  TextEditingController postalCodeController = TextEditingController();
  TextEditingController religionController = TextEditingController();
  TextEditingController bankAccountNameController = TextEditingController();
  TextEditingController bankAccountNumberController = TextEditingController();

  bool salarySystem = false;

  EmployeeBloc({required this.repository}) : super(EmployeeInitialState());

  Future<void> createEmployee() async {
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
        fullName: firstNameController.text + " " + lastNameController.text,
        phoneNo: '(022) ${homeNumberController.text}',
        bloodGroup: bloodGroupController.text,
        bornCity: bornCityController.text,
        bornDate: bornDateController.text,
        citizen: citizenController.text,
        education: educationController.text,
        employeeId: '',
        familyCardNo: familyCardNoController.text,
        gender: genderController.text.toUpperCase(),
        isDeleted: false,
        maritalDate: '1999-02-07',
        maritalStatus: '0',
        passportNo: '12345678',
        postalCode: postalCodeController.text,
        religion: religionController.text.contains('islam') ? '1' : '2',
        salarySystem: salarySystem ? 'SET' : 'NOT SET',
      );
    } catch (e) {
      emit(
        EmployeeFailedState(code: 500, message: e.toString()),
      );
    }

    Either<Failure, int> result = await repository.createEmployee(entity!);

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

        // var containst =
        //     listEmployee!.where((element) => element.userId == App.main.idUser);
        // if (containst.isEmpty) {
        //   isAlreadyregisterEmployee = false;
        // } else {
        //   isAlreadyregisterEmployee = true;
        // }

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
