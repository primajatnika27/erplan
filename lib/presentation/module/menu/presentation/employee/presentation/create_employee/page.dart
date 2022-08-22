import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

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

    _employeeBloc.bloodGroupController.text = 'A';
    _employeeBloc.citizenController.text = 'WNI';
    _employeeBloc.educationController.text = 'S1';
    _employeeBloc.genderController.text = 'L';
    _employeeBloc.bankAccountNameController.text = 'BCA';
    _employeeBloc.religionController.text = '';

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
                            /// Identity Field
                            TextFormField(
                              controller:
                                  _employeeBloc.identityNumberController,
                              style: TextStyle(
                                fontSize: 14.sp,
                                color: Colors.white,
                              ),
                              decoration: InputDecoration(
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.always,
                                label: Text('Indentity No.'),
                                labelStyle: TextStyle(
                                  color: Color.fromRGBO(120, 125, 131, 1),
                                ),
                                isDense: true,
                                contentPadding: EdgeInsets.symmetric(
                                  vertical: 5.h,
                                ),
                                hintText: 'Please input yout identity number',
                                hintStyle: TextStyle(
                                  fontSize: 14.sp,
                                  color: Color.fromRGBO(120, 125, 131, 1),
                                ),
                                border: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color.fromRGBO(44, 150, 213, 1),
                                  ),
                                ),
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color.fromRGBO(44, 150, 213, 1),
                                  ),
                                ),
                              ),
                              keyboardType: TextInputType.number,
                              validator: (value) {
                                if (value!.trim().isEmpty) {
                                  return 'identity no is required.';
                                }

                                if (value.length < 16) {
                                  return 'identity no required 16 number.';
                                }
                                return null;
                              },
                            ),
                            SizedBox(height: 35.h),

                            /// Family Card Field
                            TextFormField(
                              controller: _employeeBloc.familyCardNoController,
                              style: TextStyle(
                                fontSize: 14.sp,
                                color: Colors.white,
                              ),
                              decoration: InputDecoration(
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.always,
                                label: Text('Family Card No.'),
                                labelStyle: TextStyle(
                                  color: Color.fromRGBO(120, 125, 131, 1),
                                ),
                                isDense: true,
                                contentPadding: EdgeInsets.symmetric(
                                  vertical: 5.h,
                                ),
                                hintText:
                                    'Please input your family card number',
                                hintStyle: TextStyle(
                                  fontSize: 14.sp,
                                  color: Color.fromRGBO(120, 125, 131, 1),
                                ),
                                border: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color.fromRGBO(44, 150, 213, 1),
                                  ),
                                ),
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color.fromRGBO(44, 150, 213, 1),
                                  ),
                                ),
                              ),
                              keyboardType: TextInputType.number,
                              validator: (value) {
                                if (value!.trim().isEmpty) {
                                  return 'identity no is required.';
                                }

                                return null;
                              },
                            ),
                            SizedBox(height: 35.h),

                            /// Fullname Field
                            Row(
                              children: [
                                Expanded(
                                  flex: 5,
                                  child: TextFormField(
                                    controller:
                                        _employeeBloc.firstNameController,
                                    style: TextStyle(
                                      fontSize: 14.sp,
                                      color: Colors.white,
                                    ),
                                    decoration: InputDecoration(
                                      isDense: true,
                                      contentPadding: EdgeInsets.symmetric(
                                        vertical: 5.h,
                                      ),
                                      floatingLabelBehavior:
                                          FloatingLabelBehavior.always,
                                      label: Text('First'),
                                      labelStyle: TextStyle(
                                        color: Color.fromRGBO(120, 125, 131, 1),
                                      ),
                                      hintText: 'Your first name',
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
                                Spacer(
                                  flex: 1,
                                ),
                                Expanded(
                                  flex: 5,
                                  child: TextFormField(
                                    controller:
                                        _employeeBloc.lastNameController,
                                    style: TextStyle(
                                      fontSize: 14.sp,
                                      color: Colors.white,
                                    ),
                                    decoration: InputDecoration(
                                      isDense: true,
                                      contentPadding: EdgeInsets.symmetric(
                                        vertical: 5.h,
                                      ),
                                      floatingLabelBehavior:
                                          FloatingLabelBehavior.always,
                                      label: Text('Last'),
                                      labelStyle: TextStyle(
                                        color: Color.fromRGBO(120, 125, 131, 1),
                                      ),
                                      hintText: 'Your last name',
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

                            /// Born Date Field
                            TextFormField(
                              controller: _employeeBloc.bornDateController,
                              readOnly: true,
                              onTap: () async {
                                DateTime? pickedDate = await showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime(2000),
                                  lastDate: DateTime(2100),
                                );

                                if (pickedDate != null) {
                                  String formattedDate =
                                      DateFormat('yyyy-MM-dd')
                                          .format(pickedDate);

                                  setState(() {
                                    _employeeBloc.bornDateController.text =
                                        formattedDate; //set output date to TextField value.
                                  });
                                }
                              },
                              style: TextStyle(
                                fontSize: 12.sp,
                                color: Colors.white,
                              ),
                              decoration: InputDecoration(
                                suffixIcon: Icon(
                                  Icons.chevron_right_outlined,
                                  size: 22.h,
                                ),
                                label: Text("Born Date"),
                                labelStyle: TextStyle(
                                  color: Color.fromRGBO(120, 125, 131, 1),
                                ),
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.always,
                                isDense: true,
                                contentPadding: EdgeInsets.symmetric(
                                  vertical: 5.h,
                                ),
                                hintText: 'Date',
                                hintStyle: TextStyle(
                                  fontSize: 14.sp,
                                  color: Color.fromRGBO(120, 125, 131, 1),
                                ),
                                border: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.white54,
                                  ),
                                ),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.white54,
                                  ),
                                ),
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.white54,
                                  ),
                                ),
                              ),
                              keyboardType: TextInputType.emailAddress,
                              validator: (value) {
                                if (value!.trim().isEmpty) {
                                  return '*required';
                                }
                                return null;
                              },
                            ),
                            SizedBox(height: 35.h),

                            /// Bord City Field
                            TextFormField(
                              controller: _employeeBloc.bornCityController,
                              style: TextStyle(
                                fontSize: 14.sp,
                                color: Colors.white,
                              ),
                              decoration: InputDecoration(
                                isDense: true,
                                contentPadding: EdgeInsets.symmetric(
                                  vertical: 5.h,
                                ),
                                label: Text("Born City"),
                                labelStyle: TextStyle(
                                  color: Color.fromRGBO(120, 125, 131, 1),
                                ),
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.always,
                                hintText: 'Input your born city',
                                hintStyle: TextStyle(
                                  fontSize: 14.sp,
                                  color: Color.fromRGBO(120, 125, 131, 1),
                                ),
                                border: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color.fromRGBO(44, 150, 213, 1),
                                  ),
                                ),
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color.fromRGBO(44, 150, 213, 1),
                                  ),
                                ),
                              ),
                              keyboardType: TextInputType.text,
                              validator: (value) {
                                if (value!.trim().isEmpty) {
                                  return 'born city is required.';
                                }

                                return null;
                              },
                            ),
                            SizedBox(height: 35.h),

                            /// Education Field
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Gender',
                                  style: TextStyle(
                                    color: Color.fromRGBO(120, 125, 131, 1),
                                  ),
                                ),
                                DropdownButton<String>(
                                  value: _employeeBloc.genderController.text,
                                  icon: Icon(
                                    Icons.chevron_right_outlined,
                                    size: 22.h,
                                  ),
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  dropdownColor: Color.fromRGBO(30, 37, 43, 1),
                                  underline: Container(
                                    height: 1,
                                    color: Color.fromRGBO(44, 150, 213, 1),
                                  ),
                                  isExpanded: true,
                                  onChanged: (String? newValue) {
                                    setState(() {
                                      _employeeBloc.genderController.text =
                                          newValue!;
                                    });
                                  },
                                  items: <String>['L', 'P']
                                      .map<DropdownMenuItem<String>>(
                                          (String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(
                                        value,
                                      ),
                                    );
                                  }).toList(),
                                ),
                              ],
                            ),
                            SizedBox(height: 35.h),

                            /// Phone Field
                            Row(
                              children: [
                                Expanded(
                                  flex: 5,
                                  child: TextFormField(
                                    controller:
                                        _employeeBloc.phoneNumberController,
                                    style: TextStyle(
                                      fontSize: 14.sp,
                                      color: Colors.white,
                                    ),
                                    decoration: InputDecoration(
                                      isDense: true,
                                      contentPadding: EdgeInsets.symmetric(
                                        vertical: 5.h,
                                      ),
                                      label: Text("Mobile No."),
                                      labelStyle: TextStyle(
                                        color: Color.fromRGBO(120, 125, 131, 1),
                                      ),
                                      floatingLabelBehavior:
                                          FloatingLabelBehavior.always,
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
                                Spacer(
                                  flex: 1,
                                ),
                                Expanded(
                                  flex: 5,
                                  child: TextFormField(
                                    controller:
                                        _employeeBloc.homeNumberController,
                                    style: TextStyle(
                                      fontSize: 14.sp,
                                      color: Colors.white,
                                    ),
                                    decoration: InputDecoration(
                                      isDense: true,
                                      prefixStyle: TextStyle(
                                        fontSize: 14.sp,
                                        color: Color.fromRGBO(120, 125, 131, 1),
                                      ),
                                      prefix: Text('(022)'),
                                      label: Text("Home No."),
                                      labelStyle: TextStyle(
                                        color: Color.fromRGBO(120, 125, 131, 1),
                                      ),
                                      floatingLabelBehavior:
                                          FloatingLabelBehavior.always,
                                      contentPadding: EdgeInsets.symmetric(
                                        vertical: 5.h,
                                      ),
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
                                      return null;
                                    },
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 35.h),

                            /// Emergency Field
                            TextFormField(
                              controller:
                                  _employeeBloc.emergencyNumberController,
                              style: TextStyle(
                                fontSize: 14.sp,
                                color: Colors.white,
                              ),
                              decoration: InputDecoration(
                                isDense: true,
                                contentPadding: EdgeInsets.symmetric(
                                  vertical: 5.h,
                                ),
                                label: Text("Emergency Phone No."),
                                labelStyle: TextStyle(
                                  color: Color.fromRGBO(120, 125, 131, 1),
                                ),
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.always,
                                hintText: 'Input Phone Number',
                                hintStyle: TextStyle(
                                  fontSize: 14.sp,
                                  color: Color.fromRGBO(120, 125, 131, 1),
                                ),
                                border: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color.fromRGBO(44, 150, 213, 1),
                                  ),
                                ),
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color.fromRGBO(44, 150, 213, 1),
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
                            SizedBox(height: 35.h),

                            /// Religion Field
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Religion',
                                  style: TextStyle(
                                    color: Color.fromRGBO(120, 125, 131, 1),
                                  ),
                                ),
                                DropdownButton<String>(
                                  value: _employeeBloc.religionController.text,
                                  icon: Icon(
                                    Icons.chevron_right_outlined,
                                    size: 22.h,
                                  ),
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  dropdownColor: Color.fromRGBO(30, 37, 43, 1),
                                  underline: Container(
                                    height: 1,
                                    color: Color.fromRGBO(44, 150, 213, 1),
                                  ),
                                  isExpanded: true,
                                  onChanged: (String? newValue) {
                                    setState(() {
                                      _employeeBloc.religionController.text =
                                          newValue!;
                                    });
                                  },
                                  items: <String>[
                                    '',
                                    'Islam',
                                    'Kristen',
                                    'Hindu',
                                    'Budha'
                                  ].map<DropdownMenuItem<String>>(
                                      (String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(
                                        value,
                                      ),
                                    );
                                  }).toList(),
                                ),
                              ],
                            ),
                            SizedBox(height: 35.h),

                            /// Blood Field
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Blood Group',
                                  style: TextStyle(
                                    color: Color.fromRGBO(120, 125, 131, 1),
                                  ),
                                ),
                                DropdownButton<String>(
                                  value:
                                      _employeeBloc.bloodGroupController.text,
                                  icon: Icon(
                                    Icons.chevron_right_outlined,
                                    size: 22.h,
                                  ),
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  dropdownColor: Color.fromRGBO(30, 37, 43, 1),
                                  underline: Container(
                                    height: 1,
                                    color: Color.fromRGBO(44, 150, 213, 1),
                                  ),
                                  isExpanded: true,
                                  onChanged: (String? newValue) {
                                    setState(() {
                                      _employeeBloc.bloodGroupController.text =
                                          newValue!;
                                    });
                                  },
                                  items: <String>['O', 'A', 'AB', 'B']
                                      .map<DropdownMenuItem<String>>(
                                          (String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(
                                        value,
                                      ),
                                    );
                                  }).toList(),
                                ),
                              ],
                            ),
                            SizedBox(height: 35.h),

                            /// Citizen Field
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Citizen',
                                  style: TextStyle(
                                    color: Color.fromRGBO(120, 125, 131, 1),
                                  ),
                                ),
                                DropdownButton<String>(
                                  value: _employeeBloc.citizenController.text,
                                  icon: Icon(
                                    Icons.chevron_right_outlined,
                                    size: 22.h,
                                  ),
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  dropdownColor: Color.fromRGBO(30, 37, 43, 1),
                                  underline: Container(
                                    height: 1,
                                    color: Color.fromRGBO(44, 150, 213, 1),
                                  ),
                                  isExpanded: true,
                                  onChanged: (String? newValue) {
                                    setState(() {
                                      _employeeBloc.citizenController.text =
                                          newValue!;
                                    });
                                  },
                                  items: <String>['WNI', 'WNA']
                                      .map<DropdownMenuItem<String>>(
                                          (String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(
                                        value,
                                      ),
                                    );
                                  }).toList(),
                                ),
                              ],
                            ),
                            SizedBox(height: 35.h),

                            /// Education Field
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Education',
                                  style: TextStyle(
                                    color: Color.fromRGBO(120, 125, 131, 1),
                                  ),
                                ),
                                DropdownButton<String>(
                                  value: _employeeBloc.educationController.text,
                                  icon: Icon(
                                    Icons.chevron_right_outlined,
                                    size: 22.h,
                                  ),
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  dropdownColor: Color.fromRGBO(30, 37, 43, 1),
                                  underline: Container(
                                    height: 1,
                                    color: Color.fromRGBO(44, 150, 213, 1),
                                  ),
                                  isExpanded: true,
                                  onChanged: (String? newValue) {
                                    setState(() {
                                      _employeeBloc.educationController.text =
                                          newValue!;
                                    });
                                  },
                                  items: <String>['S1', 'S2', 'Dll']
                                      .map<DropdownMenuItem<String>>(
                                          (String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(
                                        value,
                                      ),
                                    );
                                  }).toList(),
                                ),
                              ],
                            ),
                            SizedBox(height: 35.h),

                            /// City Field
                            TextFormField(
                              controller: _employeeBloc.cityController,
                              style: TextStyle(
                                fontSize: 14.sp,
                                color: Colors.white,
                              ),
                              decoration: InputDecoration(
                                isDense: true,
                                contentPadding: EdgeInsets.symmetric(
                                  vertical: 5.h,
                                ),
                                label: Text("City"),
                                labelStyle: TextStyle(
                                  color: Color.fromRGBO(120, 125, 131, 1),
                                ),
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.always,
                                hintText: 'Input City',
                                hintStyle: TextStyle(
                                  fontSize: 14.sp,
                                  color: Color.fromRGBO(120, 125, 131, 1),
                                ),
                                border: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color.fromRGBO(44, 150, 213, 1),
                                  ),
                                ),
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color.fromRGBO(44, 150, 213, 1),
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
                            SizedBox(height: 35.h),

                            /// Province Field
                            TextFormField(
                              controller: _employeeBloc.provinceController,
                              style: TextStyle(
                                fontSize: 14.sp,
                                color: Colors.white,
                              ),
                              decoration: InputDecoration(
                                isDense: true,
                                contentPadding: EdgeInsets.symmetric(
                                  vertical: 5.h,
                                ),
                                label: Text("Province"),
                                labelStyle: TextStyle(
                                  color: Color.fromRGBO(120, 125, 131, 1),
                                ),
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.always,
                                hintText: 'Input Province',
                                hintStyle: TextStyle(
                                  fontSize: 14.sp,
                                  color: Color.fromRGBO(120, 125, 131, 1),
                                ),
                                border: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color.fromRGBO(44, 150, 213, 1),
                                  ),
                                ),
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color.fromRGBO(44, 150, 213, 1),
                                  ),
                                ),
                              ),
                              keyboardType: TextInputType.text,
                              validator: (value) {
                                if (value!.trim().isEmpty) {
                                  return 'province is required.';
                                }
                                return null;
                              },
                            ),
                            SizedBox(height: 35.h),

                            /// Full Adress Field
                            TextFormField(
                              controller: _employeeBloc.fullAdressController,
                              style: TextStyle(
                                fontSize: 14.sp,
                                color: Colors.white,
                              ),
                              maxLines: 2,
                              decoration: InputDecoration(
                                isDense: true,
                                contentPadding: EdgeInsets.symmetric(
                                  vertical: 5.h,
                                ),
                                label: Text("Full Address"),
                                labelStyle: TextStyle(
                                  color: Color.fromRGBO(120, 125, 131, 1),
                                ),
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.always,
                                hintText: 'Input Full Address',
                                hintStyle: TextStyle(
                                  fontSize: 14.sp,
                                  color: Color.fromRGBO(120, 125, 131, 1),
                                ),
                                border: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color.fromRGBO(44, 150, 213, 1),
                                  ),
                                ),
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color.fromRGBO(44, 150, 213, 1),
                                  ),
                                ),
                              ),
                              keyboardType: TextInputType.text,
                              validator: (value) {
                                if (value!.trim().isEmpty) {
                                  return 'Full Address is required.';
                                }
                                return null;
                              },
                            ),
                            SizedBox(height: 35.h),

                            /// Postal Code Field
                            TextFormField(
                              controller: _employeeBloc.postalCodeController,
                              style: TextStyle(
                                fontSize: 14.sp,
                                color: Colors.white,
                              ),
                              decoration: InputDecoration(
                                isDense: true,
                                contentPadding: EdgeInsets.symmetric(
                                  vertical: 5.h,
                                ),
                                label: Text("Postal Code"),
                                labelStyle: TextStyle(
                                  color: Color.fromRGBO(120, 125, 131, 1),
                                ),
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.always,
                                hintText: 'Input Postal Code',
                                hintStyle: TextStyle(
                                  fontSize: 14.sp,
                                  color: Color.fromRGBO(120, 125, 131, 1),
                                ),
                                border: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color.fromRGBO(44, 150, 213, 1),
                                  ),
                                ),
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color.fromRGBO(44, 150, 213, 1),
                                  ),
                                ),
                              ),
                              keyboardType: TextInputType.number,
                              validator: (value) {
                                if (value!.trim().isEmpty) {
                                  return 'postal code is required.';
                                }
                                return null;
                              },
                            ),
                            SizedBox(height: 35.h),

                            /// Bank Account Name Field
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Bank Account Name',
                                  style: TextStyle(
                                    color: Color.fromRGBO(120, 125, 131, 1),
                                  ),
                                ),
                                DropdownButton<String>(
                                  value: _employeeBloc
                                      .bankAccountNameController.text,
                                  icon: Icon(
                                    Icons.chevron_right_outlined,
                                    size: 22.h,
                                  ),
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  dropdownColor: Color.fromRGBO(30, 37, 43, 1),
                                  underline: Container(
                                    height: 1,
                                    color: Color.fromRGBO(44, 150, 213, 1),
                                  ),
                                  isExpanded: true,
                                  onChanged: (String? newValue) {
                                    setState(() {
                                      _employeeBloc.bankAccountNameController
                                          .text = newValue!;
                                    });
                                  },
                                  items: <String>['BCA', 'BRI']
                                      .map<DropdownMenuItem<String>>(
                                          (String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(
                                        value,
                                      ),
                                    );
                                  }).toList(),
                                ),
                              ],
                            ),
                            SizedBox(height: 35.h),

                            /// Bank Account Number Field
                            TextFormField(
                              controller:
                                  _employeeBloc.bankAccountNumberController,
                              style: TextStyle(
                                fontSize: 16.sp,
                                color: Colors.white,
                              ),
                              decoration: InputDecoration(
                                isDense: true,
                                contentPadding: EdgeInsets.symmetric(
                                  vertical: 5.h,
                                ),
                                label: Text("Bank Account No."),
                                labelStyle: TextStyle(
                                  color: Color.fromRGBO(120, 125, 131, 1),
                                ),
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.always,
                                hintText: 'Input Bank Account Number',
                                hintStyle: TextStyle(
                                  fontSize: 14.sp,
                                  color: Color.fromRGBO(120, 125, 131, 1),
                                ),
                                border: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color.fromRGBO(44, 150, 213, 1),
                                  ),
                                ),
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color.fromRGBO(44, 150, 213, 1),
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
                            SizedBox(height: 35.h),

                            /// System Salary
                            Row(
                              children: [
                                Text(
                                  'SALARY SYSTEM',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                                Checkbox(
                                  value: _employeeBloc.salarySystem,
                                  onChanged: (value) {
                                    setState(() {
                                      _employeeBloc.salarySystem = value!;
                                    });
                                  },
                                )
                              ],
                            )
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
