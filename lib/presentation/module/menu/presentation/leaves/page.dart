import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

import '../../../../../data/model/leave/approval_leave_enum.dart';
import '../../../../../data/repository_impl/employee_repository_impl.dart';
import '../../../../../data/repository_impl/leave_repository_impl.dart';
import '../../../../../domain/entity/employee/employee_entity.dart';
import '../../../../../domain/entity/leave/leave_type_entity.dart';
import '../../../../../helper/flushbar.dart';
import '../../../../core/app.dart';
import '../../../../widget/block_loader.dart';
import '../employee/bloc.dart';
import 'bloc.dart';

class LeavesMenuPage extends StatefulWidget {
  const LeavesMenuPage({Key? key}) : super(key: key);

  @override
  State<LeavesMenuPage> createState() => _LeavesMenuPageState();
}

class _LeavesMenuPageState extends State<LeavesMenuPage> {
  late LeaveBloc _leaveBloc;
  late EmployeeBloc _employeeBloc;

  @override
  void initState() {
    _leaveBloc = LeaveBloc(
      repository: LeaveRepositoryImpl(
        client: App.main.clientAuth,
        fcmToken: App.main.firebaseToken,
        accessToken: App.main.accessToken,
      ),
    );

    _employeeBloc = EmployeeBloc(
      repository: EmployeeRepositoryImpl(
        fcmToken: App.main.firebaseToken,
        client: App.main.clientAuth,
        accessToken: App.main.accessToken,
      ),
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(30, 37, 43, 1),
      appBar: AppBar(
        title: Text("Leaves"),
        centerTitle: false,
        elevation: 2.0,
        actions: [
          ElevatedButton(
            onPressed: () {
              _leaveBloc.saveLeave();
            },
            child: Text("Save"),
            style: ButtonStyle(
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(0.0),
                ),
              ),
            ),
          ),
        ],
      ),
      body: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (BuildContext context) => _leaveBloc,
          ),
          BlocProvider(
            create: (BuildContext context) => _employeeBloc,
          ),
        ],
        child: MultiBlocListener(
          listeners: [
            BlocListener<LeaveBloc, LeaveState>(
              bloc: _leaveBloc,
              listener: (context, state) {
                if (state is SaveLeaveLoadingState) {
                  FocusScope.of(context).requestFocus(FocusNode());
                  showDialog(
                    context: context,
                    builder: (_) => BlockLoader(),
                  );
                }

                if (state is LeaveTypeSuccessState) {
                  showModalBottomSheet(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10.0),
                        topRight: Radius.circular(10.0),
                      ),
                    ),
                    backgroundColor: Color.fromRGBO(30, 37, 43, 1),
                    context: context,
                    builder: (context) {
                      return Container(
                        height: 300.w,
                        child: Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 10.w, vertical: 10.w),
                              child: Container(
                                width: 100.w,
                                height: 3.w,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(20.w),
                                ),
                              ),
                            ),
                            Expanded(
                              child: ListView.builder(
                                itemBuilder: (context, index) {
                                  return RadioListTile<LeaveTypeEntity>(
                                    value: state.entity![index],
                                    groupValue: _leaveBloc.leaveTypeEntity,
                                    onChanged: (value) {
                                      _leaveBloc.leaveTypeController.text =
                                          value!.leaveName;
                                      _leaveBloc.leaveTypeEntity = value;
                                      Navigator.pop(context);
                                    },
                                    title: Text(
                                        "${state.entity?[index].leaveName}"),
                                  );
                                },
                                itemCount: state.entity?.length,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                }

                if (state is LeaveFailedState) {
                  Navigator.of(context).pop();
                  showFlushbar(
                    context,
                    state.message,
                    isError: true,
                  );
                }

                if (state is LeaveSaveSuccessState) {
                  Navigator.of(context).pop();
                  Navigator.of(context).pop();
                  showFlushbar(context, 'Success Create Leave');
                }
              },
            ),
            BlocListener<EmployeeBloc, EmployeeState>(
              bloc: _employeeBloc,
              listener: (context, state) {
                if (state is EmployeeSuccessState) {
                  showModalBottomSheet(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10.0),
                        topRight: Radius.circular(10.0),
                      ),
                    ),
                    backgroundColor: Color.fromRGBO(30, 37, 43, 1),
                    context: context,
                    builder: (context) {
                      return Container(
                        height: 300.w,
                        child: Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 10.w, vertical: 10.w),
                              child: Container(
                                width: 100.w,
                                height: 3.w,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(20.w),
                                ),
                              ),
                            ),
                            Expanded(
                              child: ListView.builder(
                                itemBuilder: (context, index) {
                                  switch (_leaveBloc.approvalLeave) {
                                    case ApprovalLeaveEnum.EmployeeSelected:
                                      return RadioListTile<EmployeeEntity>(
                                        value: state.employee![index],
                                        groupValue:
                                            _leaveBloc.employeeSelectEntity,
                                        onChanged: (value) {
                                          _leaveBloc.employeeController.text =
                                              value!.fullName;
                                          _leaveBloc.employeeSelectEntity =
                                              value;
                                          Navigator.pop(context);
                                        },
                                        title: Text(
                                            "${state.employee?[index].fullName}"),
                                      );
                                    case ApprovalLeaveEnum.HRChecker:
                                      return RadioListTile<EmployeeEntity>(
                                        value: state.employee![index],
                                        groupValue:
                                            _leaveBloc.approvalHrCheckerEntity,
                                        onChanged: (value) {
                                          _leaveBloc.approvalHrCheckerController
                                              .text = value!.fullName;
                                          _leaveBloc.approvalHrCheckerEntity =
                                              value;
                                          Navigator.pop(context);
                                        },
                                        title: Text(
                                            "${state.employee?[index].fullName}"),
                                      );
                                    case ApprovalLeaveEnum.HRHead:
                                      return RadioListTile<EmployeeEntity>(
                                        value: state.employee![index],
                                        groupValue:
                                            _leaveBloc.approvalHrHeadEntity,
                                        onChanged: (value) {
                                          _leaveBloc.approvalHrHeadController
                                              .text = value!.fullName;
                                          _leaveBloc.approvalHrHeadEntity =
                                              value;
                                          Navigator.pop(context);
                                        },
                                        title: Text(
                                            "${state.employee?[index].fullName}"),
                                      );
                                    case ApprovalLeaveEnum.Direction:
                                      return RadioListTile<EmployeeEntity>(
                                        value: state.employee![index],
                                        groupValue:
                                            _leaveBloc.approvalDirectionEntity,
                                        onChanged: (value) {
                                          _leaveBloc.approvalDirectionController
                                              .text = value!.fullName;
                                          _leaveBloc.approvalDirectionEntity =
                                              value;
                                          Navigator.pop(context);
                                        },
                                        title: Text(
                                            "${state.employee?[index].fullName}"),
                                      );
                                    case ApprovalLeaveEnum.SPV:
                                      return RadioListTile<EmployeeEntity>(
                                        value: state.employee![index],
                                        groupValue:
                                            _leaveBloc.approvalSpvEntity,
                                        onChanged: (value) {
                                          _leaveBloc.approvalSpvController
                                              .text = value!.fullName;
                                          _leaveBloc.approvalSpvEntity = value;

                                          Navigator.pop(context);
                                        },
                                        title: Text(
                                            "${state.employee?[index].fullName}"),
                                      );
                                    case ApprovalLeaveEnum.Replace:
                                      return RadioListTile<EmployeeEntity>(
                                        value: state.employee![index],
                                        groupValue:
                                            _leaveBloc.replaceEmployeeEntity,
                                        onChanged: (value) {
                                          _leaveBloc.replaceEmployeeController
                                              .text = value!.fullName;
                                          _leaveBloc.replaceEmployeeEntity =
                                              value;
                                          Navigator.pop(context);
                                        },
                                        title: Text(
                                            "${state.employee?[index].fullName}"),
                                      );
                                    default:
                                      return SizedBox();
                                  }
                                },
                                itemCount: state.employee?.length,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                }
              },
            ),
          ],
          child: Form(
            key: _leaveBloc.formKey,
            child: CustomScrollView(
              slivers: [
                SliverList(
                  delegate: SliverChildListDelegate([
                    SizedBox(height: 20.h),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 15.w),
                      child: TextFormField(
                        controller: _leaveBloc.leaveTypeController,
                        readOnly: true,
                        onTap: () {
                          _leaveBloc.getLeaveType();
                        },
                        style: TextStyle(
                          fontSize: 12.sp,
                          color: Colors.white,
                        ),
                        decoration: InputDecoration(
                          prefixIcon: Icon(
                            Icons.document_scanner,
                            size: 22.h,
                          ),
                          suffixIcon: Icon(
                            Icons.chevron_right_outlined,
                            size: 22.h,
                          ),
                          label: Text("Leave type"),
                          labelStyle: TextStyle(
                            color: Colors.white60,
                          ),
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          isDense: true,
                          contentPadding: EdgeInsets.symmetric(
                            vertical: 5.h,
                          ),
                          hintText: 'Please select',
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
                    ),
                    SizedBox(height: 20.h),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 15.w),
                      child: TextFormField(
                        controller: _leaveBloc.employeeController,
                        readOnly: true,
                        onTap: () {
                          _leaveBloc.approvalLeave =
                              ApprovalLeaveEnum.EmployeeSelected;
                          _employeeBloc.getAllEmployee();
                        },
                        style: TextStyle(
                          fontSize: 12.sp,
                          color: Colors.white,
                        ),
                        decoration: InputDecoration(
                          prefixIcon: Icon(
                            Icons.perm_contact_cal_outlined,
                            size: 22.h,
                          ),
                          suffixIcon: Icon(
                            Icons.chevron_right_outlined,
                            size: 22.h,
                          ),
                          label: Text("Employee"),
                          labelStyle: TextStyle(
                            color: Colors.white60,
                          ),
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          isDense: true,
                          contentPadding: EdgeInsets.symmetric(
                            vertical: 5.h,
                          ),
                          hintText: 'Please select employee',
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
                    ),
                    SizedBox(height: 20.h),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 15.w),
                      child: TextFormField(
                        controller: _leaveBloc.approvalHrCheckerController,
                        readOnly: true,
                        onTap: () {
                          _leaveBloc.approvalLeave =
                              ApprovalLeaveEnum.HRChecker;
                          _employeeBloc.getAllEmployee();
                        },
                        style: TextStyle(
                          fontSize: 12.sp,
                          color: Colors.white,
                        ),
                        decoration: InputDecoration(
                          prefixIcon: Icon(
                            Icons.people,
                            size: 22.h,
                          ),
                          suffixIcon: Icon(
                            Icons.chevron_right_outlined,
                            size: 22.h,
                          ),
                          label: Text("Approval HR Checker"),
                          labelStyle: TextStyle(
                            color: Colors.white60,
                          ),
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          isDense: true,
                          contentPadding: EdgeInsets.symmetric(
                            vertical: 5.h,
                          ),
                          hintText: 'Please select',
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
                    ),
                    SizedBox(height: 20.h),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 15.w),
                      child: TextFormField(
                        controller: _leaveBloc.approvalHrHeadController,
                        readOnly: true,
                        onTap: () {
                          _leaveBloc.approvalLeave = ApprovalLeaveEnum.HRHead;
                          _employeeBloc.getAllEmployee();
                        },
                        style: TextStyle(
                          fontSize: 12.sp,
                          color: Colors.white,
                        ),
                        decoration: InputDecoration(
                          prefixIcon: Icon(
                            Icons.people,
                            size: 22.h,
                          ),
                          suffixIcon: Icon(
                            Icons.chevron_right_outlined,
                            size: 22.h,
                          ),
                          label: Text("Approval HR Head"),
                          labelStyle: TextStyle(
                            color: Colors.white60,
                          ),
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          isDense: true,
                          contentPadding: EdgeInsets.symmetric(
                            vertical: 5.h,
                          ),
                          hintText: 'Please select',
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
                    ),
                    SizedBox(height: 20.h),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 15.w),
                      child: TextFormField(
                        controller: _leaveBloc.approvalSpvController,
                        readOnly: true,
                        onTap: () {
                          _leaveBloc.approvalLeave = ApprovalLeaveEnum.SPV;
                          _employeeBloc.getAllEmployee();
                        },
                        style: TextStyle(
                          fontSize: 12.sp,
                          color: Colors.white,
                        ),
                        decoration: InputDecoration(
                          prefixIcon: Icon(
                            Icons.people,
                            size: 22.h,
                          ),
                          suffixIcon: Icon(
                            Icons.chevron_right_outlined,
                            size: 22.h,
                          ),
                          label: Text("Approval SPV"),
                          labelStyle: TextStyle(
                            color: Colors.white60,
                          ),
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          isDense: true,
                          contentPadding: EdgeInsets.symmetric(
                            vertical: 5.h,
                          ),
                          hintText: 'Please select',
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
                    ),
                    SizedBox(height: 20.h),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 15.w),
                      child: TextFormField(
                        controller: _leaveBloc.approvalDirectionController,
                        readOnly: true,
                        onTap: () {
                          _leaveBloc.approvalLeave =
                              ApprovalLeaveEnum.Direction;
                          _employeeBloc.getAllEmployee();
                        },
                        style: TextStyle(
                          fontSize: 12.sp,
                          color: Colors.white,
                        ),
                        decoration: InputDecoration(
                          prefixIcon: Icon(
                            Icons.people,
                            size: 22.h,
                          ),
                          suffixIcon: Icon(
                            Icons.chevron_right_outlined,
                            size: 22.h,
                          ),
                          label: Text("Approval Direction"),
                          labelStyle: TextStyle(
                            color: Colors.white60,
                          ),
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          isDense: true,
                          contentPadding: EdgeInsets.symmetric(
                            vertical: 5.h,
                          ),
                          hintText: 'Please select',
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
                    ),
                    SizedBox(height: 25.h),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 15.w),
                      child: Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              controller: _leaveBloc.leaveFromController,
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
                                    _leaveBloc.leaveFromController.text =
                                        formattedDate; //set output date to TextField value.
                                  });
                                }
                              },
                              style: TextStyle(
                                fontSize: 12.sp,
                                color: Colors.white,
                              ),
                              decoration: InputDecoration(
                                prefixIcon: Icon(
                                  Icons.date_range,
                                  size: 22.h,
                                ),
                                suffixIcon: Icon(
                                  Icons.chevron_right_outlined,
                                  size: 22.h,
                                ),
                                label: Text("From"),
                                labelStyle: TextStyle(
                                  color: Colors.white60,
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
                          ),
                          SizedBox(width: 20.w),
                          Expanded(
                            child: TextFormField(
                              controller: _leaveBloc.leaveToController,
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
                                    _leaveBloc.leaveToController.text =
                                        formattedDate; //set output date to TextField value.
                                  });
                                }
                              },
                              style: TextStyle(
                                fontSize: 12.sp,
                                color: Colors.white,
                              ),
                              decoration: InputDecoration(
                                prefixIcon: Icon(
                                  Icons.date_range,
                                  size: 22.h,
                                ),
                                suffixIcon: Icon(
                                  Icons.chevron_right_outlined,
                                  size: 22.h,
                                ),
                                label: Text("To"),
                                labelStyle: TextStyle(
                                  color: Colors.white60,
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
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20.h),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 15.w),
                      child: TextFormField(
                        controller: _leaveBloc.replaceEmployeeController,
                        readOnly: true,
                        onTap: () {
                          _leaveBloc.approvalLeave = ApprovalLeaveEnum.Replace;
                          _employeeBloc.getAllEmployee();
                        },
                        style: TextStyle(
                          fontSize: 12.sp,
                          color: Colors.white,
                        ),
                        decoration: InputDecoration(
                          prefixIcon: Icon(
                            Icons.people,
                            size: 22.h,
                          ),
                          suffixIcon: Icon(
                            Icons.chevron_right_outlined,
                            size: 22.h,
                          ),
                          label: Text("Replace Employee"),
                          labelStyle: TextStyle(
                            color: Colors.white60,
                          ),
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          isDense: true,
                          contentPadding: EdgeInsets.symmetric(
                            vertical: 5.h,
                          ),
                          hintText: 'Please select',
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
                    ),
                    SizedBox(height: 25.h),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 15.w),
                      child: TextFormField(
                        controller: _leaveBloc.returnDateController,
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
                                DateFormat('yyyy-MM-dd').format(pickedDate);

                            setState(() {
                              _leaveBloc.returnDateController.text =
                                  formattedDate; //set output date to TextField value.
                            });
                          }
                        },
                        style: TextStyle(
                          fontSize: 12.sp,
                          color: Colors.white,
                        ),
                        decoration: InputDecoration(
                          prefixIcon: Icon(
                            Icons.date_range,
                            size: 22.h,
                          ),
                          suffixIcon: Icon(
                            Icons.chevron_right_outlined,
                            size: 22.h,
                          ),
                          label: Text("Return Work"),
                          labelStyle: TextStyle(
                            color: Colors.white60,
                          ),
                          floatingLabelBehavior: FloatingLabelBehavior.always,
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
                    ),
                    SizedBox(height: 25.h),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 15.w),
                      child: TextFormField(
                        controller: _leaveBloc.reasonController,
                        maxLines: 2,
                        style: TextStyle(
                          fontSize: 16.sp,
                          color: Colors.white,
                        ),
                        decoration: InputDecoration(
                          isDense: true,
                          contentPadding: EdgeInsets.symmetric(
                            vertical: 5.h,
                          ),
                          hintText: 'Type your leave reason',
                          hintStyle: TextStyle(
                            fontSize: 12.sp,
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
                    ),
                    SizedBox(height: 20.h),
                  ]),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
