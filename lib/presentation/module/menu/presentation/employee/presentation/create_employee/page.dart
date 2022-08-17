import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../../data/repository_impl/employee_repository_impl.dart';
import '../../../../../../../helper/flushbar.dart';
import '../../../../../../core/app.dart';
import '../../../../../../widget/block_loader.dart';
import '../../bloc.dart';

class CreateEmployeePage extends StatefulWidget {
  const CreateEmployeePage({Key? key}) : super(key: key);

  @override
  State<CreateEmployeePage> createState() => _CreateEmployeePageState();
}

class _CreateEmployeePageState extends State<CreateEmployeePage> {
  late EmployeeBloc _employeeBloc;

  @override
  void initState() {
    _employeeBloc = EmployeeBloc(
      repository: EmployeeRepositoryImpl(
        client: App.main.clientAuth,
        accessToken: App.main.accessToken,
        fcmToken: App.main.firebaseToken,
      ),
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _employeeBloc,
      child: BlocListener<EmployeeBloc, EmployeeState>(
        listener: (context, state) async {
          if (state is EmployeeLoadingState) {
            FocusScope.of(context).requestFocus(FocusNode());
            showDialog(
              context: context,
              builder: (_) => BlockLoader(),
            );
          } else if (state is EmployeeFailedState) {
            Navigator.of(context).pop();
            showFlushbar(context, state.message, isError: true);
          } else if (state is EmployeeRegisterGoState) {
            try {
              await Future.delayed(Duration(seconds: 1));
              Modular.to.pop();
            } catch (e) {
              Navigator.of(context).pop();
            }
          }
        },
        child: Scaffold(
          appBar: AppBar(
            title: Text('Create Employee'),
            backgroundColor: Color.fromRGBO(30, 37, 43, 1),
          ),
          backgroundColor: Color.fromRGBO(30, 37, 43, 1),
          body: Form(
            key: _employeeBloc.formKey,
            child: CustomScrollView(
              slivers: [
                SliverList(
                  delegate: SliverChildListDelegate(
                    [
                      SizedBox(height: 20.h),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 34.w),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: Padding(
                                    padding: EdgeInsets.only(right: 20.w),
                                    child: Text(
                                      "Identity No.",
                                      style: TextStyle(
                                        color: Color.fromRGBO(120, 125, 131, 1),
                                      ),
                                      textAlign: TextAlign.left,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 2,
                                  child: TextFormField(
                                    controller:
                                        _employeeBloc.identityNumberController,
                                    style: TextStyle(
                                      fontSize: 16.sp,
                                      color: Colors.white,
                                    ),
                                    decoration: InputDecoration(
                                      isDense: true,
                                      contentPadding: EdgeInsets.symmetric(
                                        vertical: 5.h,
                                      ),
                                      hintText: 'Input Identity No',
                                      hintStyle: TextStyle(
                                        fontSize: 14.sp,
                                        color: Color.fromRGBO(120, 125, 131, 1),
                                      ),
                                      border: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                          color:
                                              Color.fromRGBO(44, 150, 213, 1),
                                        ),
                                      ),
                                      enabledBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                          color:
                                              Color.fromRGBO(44, 150, 213, 1),
                                        ),
                                      ),
                                    ),
                                    keyboardType: TextInputType.number,
                                    validator: (value) {
                                      if (value!.trim().isEmpty) {
                                        return 'identity no is required.';
                                      }

                                      if (value.length <= 16) {
                                        return 'identity no required 16 number.';
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 35.h),
                            Row(
                              children: [
                                Expanded(
                                  child: Padding(
                                    padding: EdgeInsets.only(right: 20.w),
                                    child: Text(
                                      "Fullname",
                                      style: TextStyle(
                                        color: Color.fromRGBO(120, 125, 131, 1),
                                      ),
                                      textAlign: TextAlign.left,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 2,
                                  child: TextFormField(
                                    controller:
                                        _employeeBloc.fullnameController,
                                    style: TextStyle(
                                      fontSize: 16.sp,
                                      color: Colors.white,
                                    ),
                                    decoration: InputDecoration(
                                      isDense: true,
                                      contentPadding: EdgeInsets.symmetric(
                                        vertical: 5.h,
                                      ),
                                      hintText: 'Input your name',
                                      hintStyle: TextStyle(
                                        fontSize: 14.sp,
                                        color: Color.fromRGBO(120, 125, 131, 1),
                                      ),
                                      border: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                          color:
                                              Color.fromRGBO(44, 150, 213, 1),
                                        ),
                                      ),
                                      enabledBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                          color:
                                              Color.fromRGBO(44, 150, 213, 1),
                                        ),
                                      ),
                                    ),
                                    keyboardType: TextInputType.name,
                                    validator: (value) {
                                      if (value!.trim().isEmpty) {
                                        return 'fullname is required.';
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 35.h),
                            Row(
                              children: [
                                Expanded(
                                  child: Padding(
                                    padding: EdgeInsets.only(right: 20.w),
                                    child: Text(
                                      "Phone No.",
                                      style: TextStyle(
                                        color: Color.fromRGBO(120, 125, 131, 1),
                                      ),
                                      textAlign: TextAlign.left,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 2,
                                  child: TextFormField(
                                    controller:
                                        _employeeBloc.phoneNumberController,
                                    style: TextStyle(
                                      fontSize: 16.sp,
                                      color: Colors.white,
                                    ),
                                    decoration: InputDecoration(
                                      isDense: true,
                                      contentPadding: EdgeInsets.symmetric(
                                        vertical: 5.h,
                                      ),
                                      hintText: 'Input Phone Number',
                                      hintStyle: TextStyle(
                                        fontSize: 14.sp,
                                        color: Color.fromRGBO(120, 125, 131, 1),
                                      ),
                                      border: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                          color:
                                              Color.fromRGBO(44, 150, 213, 1),
                                        ),
                                      ),
                                      enabledBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                          color:
                                              Color.fromRGBO(44, 150, 213, 1),
                                        ),
                                      ),
                                    ),
                                    keyboardType: TextInputType.number,
                                    validator: (value) {
                                      if (value!.trim().isEmpty) {
                                        return 'phone number is required.';
                                      }

                                      if (value.length <= 11) {
                                        return 'phone is required length.';
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 35.h),
                            Row(
                              children: [
                                Expanded(
                                  child: Padding(
                                    padding: EdgeInsets.only(right: 20.w),
                                    child: Text(
                                      "Emergency No.",
                                      style: TextStyle(
                                        color: Color.fromRGBO(120, 125, 131, 1),
                                      ),
                                      textAlign: TextAlign.left,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 2,
                                  child: TextFormField(
                                    controller:
                                        _employeeBloc.emergencyNumberController,
                                    style: TextStyle(
                                      fontSize: 16.sp,
                                      color: Colors.white,
                                    ),
                                    decoration: InputDecoration(
                                      isDense: true,
                                      contentPadding: EdgeInsets.symmetric(
                                        vertical: 5.h,
                                      ),
                                      hintText: 'Input Phone Number',
                                      hintStyle: TextStyle(
                                        fontSize: 14.sp,
                                        color: Color.fromRGBO(120, 125, 131, 1),
                                      ),
                                      border: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                          color:
                                              Color.fromRGBO(44, 150, 213, 1),
                                        ),
                                      ),
                                      enabledBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                          color:
                                              Color.fromRGBO(44, 150, 213, 1),
                                        ),
                                      ),
                                    ),
                                    keyboardType: TextInputType.number,
                                    validator: (value) {
                                      if (value!.trim().isEmpty) {
                                        return 'emergency number is required.';
                                      }

                                      if (value.length <= 11) {
                                        return 'emergency is required length.';
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 35.h),
                            Row(
                              children: [
                                Expanded(
                                  child: Padding(
                                    padding: EdgeInsets.only(right: 20.w),
                                    child: Text(
                                      "City",
                                      style: TextStyle(
                                        color: Color.fromRGBO(120, 125, 131, 1),
                                      ),
                                      textAlign: TextAlign.left,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 2,
                                  child: TextFormField(
                                    controller: _employeeBloc.cityController,
                                    style: TextStyle(
                                      fontSize: 16.sp,
                                      color: Colors.white,
                                    ),
                                    decoration: InputDecoration(
                                      isDense: true,
                                      contentPadding: EdgeInsets.symmetric(
                                        vertical: 5.h,
                                      ),
                                      hintText: 'Input City',
                                      hintStyle: TextStyle(
                                        fontSize: 14.sp,
                                        color: Color.fromRGBO(120, 125, 131, 1),
                                      ),
                                      border: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                          color:
                                              Color.fromRGBO(44, 150, 213, 1),
                                        ),
                                      ),
                                      enabledBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                          color:
                                              Color.fromRGBO(44, 150, 213, 1),
                                        ),
                                      ),
                                    ),
                                    keyboardType: TextInputType.text,
                                    validator: (value) {
                                      if (value!.trim().isEmpty) {
                                        return 'city is required.';
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 35.h),
                            Row(
                              children: [
                                Expanded(
                                  child: Padding(
                                    padding: EdgeInsets.only(right: 20.w),
                                    child: Text(
                                      "Full Address",
                                      style: TextStyle(
                                        color: Color.fromRGBO(120, 125, 131, 1),
                                      ),
                                      textAlign: TextAlign.left,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 2,
                                  child: TextFormField(
                                    controller:
                                        _employeeBloc.fullAdressController,
                                    style: TextStyle(
                                      fontSize: 16.sp,
                                      color: Colors.white,
                                    ),
                                    decoration: InputDecoration(
                                      isDense: true,
                                      contentPadding: EdgeInsets.symmetric(
                                        vertical: 5.h,
                                      ),
                                      hintText: 'Input Full Address',
                                      hintStyle: TextStyle(
                                        fontSize: 14.sp,
                                        color: Color.fromRGBO(120, 125, 131, 1),
                                      ),
                                      border: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                          color:
                                              Color.fromRGBO(44, 150, 213, 1),
                                        ),
                                      ),
                                      enabledBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                          color:
                                              Color.fromRGBO(44, 150, 213, 1),
                                        ),
                                      ),
                                    ),
                                    keyboardType: TextInputType.text,
                                    validator: (value) {
                                      if (value!.trim().isEmpty) {
                                        return 'Full address is required.';
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 35.h),
                            Row(
                              children: [
                                Expanded(
                                  child: Padding(
                                    padding: EdgeInsets.only(right: 20.w),
                                    child: Text(
                                      "Province",
                                      style: TextStyle(
                                        color: Color.fromRGBO(120, 125, 131, 1),
                                      ),
                                      textAlign: TextAlign.left,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 2,
                                  child: TextFormField(
                                    controller:
                                        _employeeBloc.provinceController,
                                    style: TextStyle(
                                      fontSize: 16.sp,
                                      color: Colors.white,
                                    ),
                                    decoration: InputDecoration(
                                      isDense: true,
                                      contentPadding: EdgeInsets.symmetric(
                                        vertical: 5.h,
                                      ),
                                      hintText: 'Input Full Address',
                                      hintStyle: TextStyle(
                                        fontSize: 14.sp,
                                        color: Color.fromRGBO(120, 125, 131, 1),
                                      ),
                                      border: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                          color:
                                              Color.fromRGBO(44, 150, 213, 1),
                                        ),
                                      ),
                                      enabledBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                          color:
                                              Color.fromRGBO(44, 150, 213, 1),
                                        ),
                                      ),
                                    ),
                                    keyboardType: TextInputType.text,
                                    validator: (value) {
                                      if (value!.trim().isEmpty) {
                                        return 'Province is required.';
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 35.h),
                            Row(
                              children: [
                                Expanded(
                                  child: Padding(
                                    padding: EdgeInsets.only(right: 20.w),
                                    child: Text(
                                      "Bank Account Name",
                                      style: TextStyle(
                                        color: Color.fromRGBO(120, 125, 131, 1),
                                      ),
                                      textAlign: TextAlign.left,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 2,
                                  child: TextFormField(
                                    controller:
                                        _employeeBloc.bankAccountNameController,
                                    style: TextStyle(
                                      fontSize: 16.sp,
                                      color: Colors.white,
                                    ),
                                    decoration: InputDecoration(
                                      isDense: true,
                                      contentPadding: EdgeInsets.symmetric(
                                        vertical: 5.h,
                                      ),
                                      hintText: 'Input Bank Account Name',
                                      hintStyle: TextStyle(
                                        fontSize: 14.sp,
                                        color: Color.fromRGBO(120, 125, 131, 1),
                                      ),
                                      border: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                          color:
                                              Color.fromRGBO(44, 150, 213, 1),
                                        ),
                                      ),
                                      enabledBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                          color:
                                              Color.fromRGBO(44, 150, 213, 1),
                                        ),
                                      ),
                                    ),
                                    keyboardType: TextInputType.text,
                                    validator: (value) {
                                      if (value!.trim().isEmpty) {
                                        return 'Bank Account is required.';
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 35.h),
                            Row(
                              children: [
                                Expanded(
                                  child: Padding(
                                    padding: EdgeInsets.only(right: 20.w),
                                    child: Text(
                                      "Bank Account Number",
                                      style: TextStyle(
                                        color: Color.fromRGBO(120, 125, 131, 1),
                                      ),
                                      textAlign: TextAlign.left,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 2,
                                  child: TextFormField(
                                    controller: _employeeBloc
                                        .bankAccountNumberController,
                                    style: TextStyle(
                                      fontSize: 16.sp,
                                      color: Colors.white,
                                    ),
                                    decoration: InputDecoration(
                                      isDense: true,
                                      contentPadding: EdgeInsets.symmetric(
                                        vertical: 5.h,
                                      ),
                                      hintText: 'Input Bank Account Number',
                                      hintStyle: TextStyle(
                                        fontSize: 14.sp,
                                        color: Color.fromRGBO(120, 125, 131, 1),
                                      ),
                                      border: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                          color:
                                              Color.fromRGBO(44, 150, 213, 1),
                                        ),
                                      ),
                                      enabledBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                          color:
                                              Color.fromRGBO(44, 150, 213, 1),
                                        ),
                                      ),
                                    ),
                                    keyboardType: TextInputType.number,
                                    validator: (value) {
                                      if (value!.trim().isEmpty) {
                                        return 'Bank Account is required.';
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 35.h),
                    ],
                  ),
                ),
              ],
            ),
          ),
          bottomNavigationBar: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  color: Color.fromRGBO(43, 49, 56, 1),
                  padding: EdgeInsets.symmetric(
                    vertical: 20.h,
                    horizontal: 16.w,
                  ),
                  child: ElevatedButton(
                    style: ButtonStyle(
                      padding: MaterialStateProperty.resolveWith(
                        (states) => EdgeInsets.symmetric(
                          horizontal: 6.w,
                          vertical: 10.w,
                        ),
                      ),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.r)),
                      ),
                    ),
                    onPressed: () {
                      FocusScope.of(context).requestFocus(FocusNode());
                      _employeeBloc.createEmployee();
                    },
                    child: Text(
                      'Register Employee',
                      style: TextStyle(
                        fontSize: 18.sp,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
