import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

import '../../../../../../data/repository_impl/approval_repository_impl.dart';
import '../../../../../../domain/entity/approval/list_approval_leave_entity.dart';
import '../../../../../../helper/flushbar.dart';
import '../../../../../core/app.dart';
import '../../../../../widget/block_loader.dart';
import '../bloc.dart';

class ApprovalDetailPage extends StatefulWidget {
  final ListApprovalLeaveEntity entity;
  const ApprovalDetailPage({Key? key, required this.entity}) : super(key: key);

  @override
  State<ApprovalDetailPage> createState() => _ApprovalDetailPageState();
}

class _ApprovalDetailPageState extends State<ApprovalDetailPage> {
  late ApprovalBloc _approvalBloc;

  @override
  void initState() {
    _approvalBloc = ApprovalBloc(
      repository: ApprovalRepositoryImpl(
        fcmToken: App.main.firebaseToken,
        client: App.main.clientAuth,
        accessToken: App.main.accessToken,
      ),
    );
    super.initState();
  }

  String dateFormat(DateTime val) {
    var dateFormatted = DateFormat("yyyy-MM-dd").format(val);
    return dateFormatted;
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _approvalBloc,
      child: BlocListener<ApprovalBloc, ApprovalState>(
        listener: (context, state) async {
          if (state is ApprovalLoadingState) {
            showDialog(
              context: context,
              builder: (_) => BlockLoader(),
            );
          }

          if (state is ApprovalFailedState) {
            Navigator.of(context).pop();
            showFlushbar(context, state.message, isError: true);
          }

          if (state is ApprovalSuccessState) {
            showFlushbar(context, 'Success Update');
            await Future.delayed(Duration(milliseconds: 500));
            Modular.to.pushReplacementNamed('/home/');
          }
        },
        child: Scaffold(
          backgroundColor: Color.fromRGBO(30, 37, 43, 1),
          appBar: AppBar(
            centerTitle: false,
            title: Text('Confirm Approval'),
          ),
          body: SingleChildScrollView(
            child: Form(
              key: _approvalBloc.formKey,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Basic Info",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14.sp,
                      ),
                    ),
                    SizedBox(
                      height: 15.h,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(
                          Icons.people,
                          size: 18,
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 10.h),
                          child: Text(
                            "${widget.entity.employeeLeave.fullName}",
                            style: TextStyle(
                              fontSize: 13.sp,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(
                          Icons.credit_card_rounded,
                          size: 18,
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 10.h),
                          child: Text(
                            "${widget.entity.leaveAddress}",
                            style: TextStyle(
                              fontSize: 13.sp,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(
                          Icons.calendar_today,
                          size: 18,
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 10.h),
                          child: Text(
                            "${dateFormat(widget.entity.leaveDate)}",
                            style: TextStyle(
                              fontSize: 13.sp,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 25.h,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Replacement Status",
                          style: TextStyle(
                            fontSize: 13.sp,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 10.h),
                          child: Text(
                            "${widget.entity.replacementStatusName}",
                            style: TextStyle(
                              fontSize: 13.sp,
                              color: widget.entity.replacementStatus == '0' ||
                                      widget.entity.replacementStatus == '2'
                                  ? Colors.red
                                  : Colors.green,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "HRD 1 Status",
                          style: TextStyle(
                            fontSize: 13.sp,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 10.h),
                          child: Text(
                            "${widget.entity.approvalStatusNameHrd1}",
                            style: TextStyle(
                              fontSize: 13.sp,
                              color: widget.entity.approvalStatusHrd1 == '0' ||
                                      widget.entity.approvalStatusHrd1 == '2'
                                  ? Colors.red
                                  : Colors.green,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "HRD 2 Status",
                          style: TextStyle(
                            fontSize: 13.sp,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 10.h),
                          child: Text(
                            "${widget.entity.approvalStatusNameHrd2}",
                            style: TextStyle(
                              fontSize: 13.sp,
                              color: widget.entity.approvalStatusHrd2 == '0' ||
                                      widget.entity.approvalStatusHrd2 == '2'
                                  ? Colors.red
                                  : Colors.green,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 45.h,
                    ),
                    Text(
                      "Leave details",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14.sp,
                      ),
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    Row(
                      children: [
                        Expanded(
                          flex: 3,
                          child: Text(
                            'Leave ID',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 9,
                          child: Text(
                            '${widget.entity.leaveId}',
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Row(
                      children: [
                        Expanded(
                          flex: 3,
                          child: Text(
                            'Leave From',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 9,
                          child: Text(
                            '${dateFormat(widget.entity.startTimeLeave)}',
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Row(
                      children: [
                        Expanded(
                          flex: 3,
                          child: Text(
                            'Leave To',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 9,
                          child: Text(
                            '${dateFormat(widget.entity.endTimeLeave)}',
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 70.h,
                    ),
                    TextFormField(
                      controller: _approvalBloc.commentController,
                      maxLines: 5,
                      decoration: InputDecoration(
                        hintText: 'Please type comment',
                        hintStyle: TextStyle(
                          color: Colors.grey,
                        ),
                      ),
                      validator: (value) {
                        if (value!.trim().isEmpty) {
                          return 'comment is required.';
                        }
                        return null;
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
          bottomNavigationBar: Padding(
            padding: MediaQuery.of(context).viewInsets,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  color: Color.fromRGBO(43, 49, 56, 1),
                  padding: EdgeInsets.only(
                    left: 16.w,
                    right: 16.w,
                    top: 16.w,
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
                      _approvalBloc.updateToApproval(
                        widget.entity.linkApproval,
                        widget.entity.leaveId,
                        widget.entity.employeeId,
                      );
                    },
                    child: Text(
                      'Approve',
                      style: TextStyle(
                        fontSize: 18.sp,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                Container(
                  color: Color.fromRGBO(43, 49, 56, 1),
                  padding: EdgeInsets.symmetric(
                    vertical: 20.h,
                    horizontal: 16.w,
                  ),
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.redAccent),
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
                      _approvalBloc.updateToReject(
                        widget.entity.linkReject,
                        widget.entity.leaveId,
                        widget.entity.employeeId,
                      );
                    },
                    child: Text(
                      'Reject',
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
