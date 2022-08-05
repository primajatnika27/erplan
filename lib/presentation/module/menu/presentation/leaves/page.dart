import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../data/model/leave/leave_type_model.dart';
import '../../../../../data/repository_impl/leave_repository_impl.dart';
import '../../../../../domain/entity/leave/leave_type_entity.dart';
import '../../../../core/app.dart';
import '../../../../widget/loader_widget.dart';
import 'bloc.dart';

class LeavesMenuPage extends StatefulWidget {
  const LeavesMenuPage({Key? key}) : super(key: key);

  @override
  State<LeavesMenuPage> createState() => _LeavesMenuPageState();
}

class _LeavesMenuPageState extends State<LeavesMenuPage> {
  late LeaveBloc _leaveBloc;

  @override
  void initState() {
    _leaveBloc = LeaveBloc(
      repository: LeaveRepositoryImpl(
        client: App.main.clientAuth,
        fcmToken: App.main.firebaseToken,
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
            onPressed: () {},
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
      body: BlocConsumer(
        bloc: _leaveBloc,
        listener: (context, state) {
          if (state is LeaveTypeSuccessState) {
            showModalBottomSheet(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)
              ),
              backgroundColor: Color.fromRGBO(30, 37, 43, 1),
              context: context,
              builder: (context) {
                return Container(
                  height: 300.w,
                  child: ListView.builder(
                    itemBuilder: (context, index) {
                      return RadioListTile(
                        value: state.entity![index].leaveName,
                        groupValue: _leaveBloc.leaveTypeController.text,
                        onChanged: (value) {
                          _leaveBloc.leaveTypeController.text = value.toString();
                          Navigator.pop(context);
                        },
                        title: Text("${state.entity?[index].leaveName}"),
                      );
                    },
                    itemCount: state.entity?.length,
                  ),
                );
              },
            );
          }
        },
        builder: (context, state) {
          return CustomScrollView(
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
                          return 'username is required.';
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
                            readOnly: true,
                            onTap: () {
                              print("asd");
                            },
                            style: TextStyle(
                              fontSize: 16.sp,
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
                                return 'username is required.';
                              }
                              return null;
                            },
                          ),
                        ),
                        SizedBox(width: 20.w),
                        Expanded(
                          child: TextFormField(
                            readOnly: true,
                            onTap: () {
                              print("asd");
                            },
                            style: TextStyle(
                              fontSize: 16.sp,
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
                                return 'username is required.';
                              }
                              return null;
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 25.h),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15.w),
                    child: TextFormField(
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
                        hintText: 'Type your message',
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
                          return 'username is required.';
                        }
                        return null;
                      },
                    ),
                  ),
                ]),
              ),
            ],
          );
        },
      ),
    );
  }
}
