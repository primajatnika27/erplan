import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:intl/intl.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../data/repository_impl/approval_repository_impl.dart';
import '../../../../../../helper/flushbar.dart';
import '../../../../../core/app.dart';
import '../../../../../widget/block_loader.dart';
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
            if (state is ApprovalLoadingState) {
              FocusScope.of(context).requestFocus(FocusNode());
              showDialog(
                context: context,
                builder: (_) => BlockLoader(),
              );
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
                                                flex: 6,
                                                child: Text(
                                                  '${state.entity?[index].leaveId}',
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                  ),
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
                                                  'Emp. Name',
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                              Expanded(
                                                flex: 6,
                                                child: Text(
                                                  '${state.entity?[index].employeeLeave.fullName}',
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
                                          Row(
                                            children: [
                                              Expanded(
                                                flex: 3,
                                                child: Text(
                                                  'Status',
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                              Expanded(
                                                flex: 6,
                                                child: Text(
                                                  '${state.entity![index].replacementStatusName}',
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: state.entity![index]
                                                                    .replacementStatus ==
                                                                '0' ||
                                                            state.entity![index]
                                                                    .replacementStatus ==
                                                                '2'
                                                        ? Colors.red
                                                        : Colors.green,
                                                  ),
                                                ),
                                              ),
                                            ],
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
