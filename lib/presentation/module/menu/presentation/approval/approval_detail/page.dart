import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../domain/entity/approval/list_approval_leave_entity.dart';

class ApprovalDetailPage extends StatefulWidget {
  final ListApprovalLeaveEntity entity;
  const ApprovalDetailPage({Key? key, required this.entity}) : super(key: key);

  @override
  State<ApprovalDetailPage> createState() => _ApprovalDetailPageState();
}

class _ApprovalDetailPageState extends State<ApprovalDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text('Confirm Approval'),
      ),
      bottomNavigationBar: Padding(
        padding: MediaQuery.of(context).viewInsets,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              color: Color.fromRGBO(43, 49, 56, 1),
              padding: EdgeInsets.symmetric(
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
    );
  }
}
