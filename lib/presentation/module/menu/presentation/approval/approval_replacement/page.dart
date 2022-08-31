import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:intl/intl.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../data/repository_impl/approval_repository_impl.dart';
import '../../../../../../helper/flushbar.dart';
import '../../../../../core/app.dart';
import '../../../../../widget/loader_widget.dart';
import '../bloc.dart';

class ApprovalReplacementPage extends StatefulWidget {
  const ApprovalReplacementPage({Key? key}) : super(key: key);

  @override
  State<ApprovalReplacementPage> createState() =>
      _ApprovalReplacementPageState();
}

class _ApprovalReplacementPageState extends State<ApprovalReplacementPage> {
  late ApprovalBloc _approvalBloc;

  @override
  void initState() {
    _approvalBloc = ApprovalBloc(
      repository: ApprovalRepositoryImpl(
        fcmToken: App.main.firebaseToken,
        client: App.main.clientAuth,
        accessToken: App.main.accessToken,
      ),
    )..getListApprovalReplacement();
    super.initState();
  }

  String dateFormat(DateTime val) {
    var dateFormatted = DateFormat("yyyy-MM-dd").format(val);
    return dateFormatted;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(30, 37, 43, 1),
      body: BlocProvider(
        create: (context) => _approvalBloc,
        child: BlocConsumer<ApprovalBloc, ApprovalState>(
          listener: (context, state) {
            if (state is ApprovalFailedState) {
              Navigator.of(context).pop();
              showFlushbar(context, state.message, isError: true);
            }
          },
          builder: (context, state) {
            if (state is ApprovalReplacementListSuccessState) {
              if (state.entity!.length < 1) {
                return Center(
                  child: Text("No Data Record"),
                );
              }

              return ListView.builder(
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.w),
                    child: Card(
                      elevation: 2.0,
                      child: InkWell(
                        onTap: () {
                          Modular.to.pushNamed('/home/approval/details',
                              arguments: state.entity?[index]);
                        },
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 20.h, vertical: 10.h),
                          child: Column(
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: Padding(
                                      padding: EdgeInsets.only(left: 10.h),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            '${state.entity?[index].employeeLeave.fullName}',
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          SizedBox(
                                            height: 5.h,
                                          ),
                                          Row(
                                            children: [
                                              Expanded(
                                                child: Text(
                                                  'From : ${dateFormat(state.entity?[index].startTimeLeave ?? DateTime.now())}',
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                              Expanded(
                                                child: Text(
                                                  'To : ${dateFormat(state.entity?[index].endTimeLeave ?? DateTime.now())}',
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 25.h,
                                          ),
                                          Text(
                                            'Reason : ${state.entity?[index].reason}',
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 15.h),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
                itemCount: state.entity?.length,
              );
            }

            return Center(
              child: Container(
                height: 100.h,
                child: LoaderWidget(),
              ),
            );
          },
        ),
      ),
    );
  }
}
