import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../data/repository_impl/employee_repository_impl.dart';
import '../../../../../helper/flushbar.dart';
import '../../../../core/app.dart';
import '../../../../widget/avatar_widget.dart';
import '../../../../widget/loader_widget.dart';
import 'bloc.dart';
import 'presentation/detail_employee/page.dart';

class EmployeeMenuPage extends StatefulWidget {
  const EmployeeMenuPage({Key? key}) : super(key: key);

  @override
  State<EmployeeMenuPage> createState() => _EmployeeMenuPageState();
}

class _EmployeeMenuPageState extends State<EmployeeMenuPage> {
  late EmployeeBloc _employeeBloc;

  @override
  void initState() {
    _employeeBloc = EmployeeBloc(
      repository: EmployeeRepositoryImpl(
        fcmToken: App.main.firebaseToken,
        client: App.main.clientAuth,
        accessToken: App.main.accessToken,
      ),
    )..getAllEmployee();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(30, 37, 43, 1),
      appBar: AppBar(
        title: appBarSearch(),
        centerTitle: false,
        elevation: 2.0,
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                _employeeBloc.isSearchEmployee =
                    !_employeeBloc.isSearchEmployee;
              });
            },
            icon: _employeeBloc.isSearchEmployee
                ? Icon(Icons.close)
                : Icon(Icons.search),
          ),
        ],
      ),
      body: BlocProvider(
        create: (context) => _employeeBloc,
        child: BlocConsumer<EmployeeBloc, EmployeeState>(
          listener: (context, state) {
            if (state is EmployeeFailedState) {
              Navigator.of(context).pop();
              showFlushbar(context, state.message, isError: true);
            }
          },
          builder: (context, state) {
            if (state is EmployeeSuccessState) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.w),
                    child: Card(
                      elevation: 2.0,
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 20.h, vertical: 10.h),
                        child: Column(
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  height: 35.h,
                                  width: 35.h,
                                  child: AvatarWidget(
                                      imageUrl:
                                          'https://pbs.twimg.com/media/EigE7IkUMAEEiUR.jpg'),
                                ),
                                Expanded(
                                  child: Padding(
                                    padding: EdgeInsets.only(left: 10.h),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          '${state.employee?[index].fullName}',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        SizedBox(height: 10.h),
                                        Text(
                                          '${state.employee?[index].addressFull}, ${state.employee?[index].addressCity}, ${state.employee?[index].province}, ${state.employee?[index].postalCode}',
                                          style: TextStyle(
                                            color: Colors.white54,
                                          ),
                                        ),
                                        SizedBox(height: 5.h),
                                        Text(
                                          '${state.employee?[index].salarySystem}',
                                          style: TextStyle(
                                            color: Colors.white54,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 15.h),
                            Divider(height: 1.h, color: Colors.white38),
                            SizedBox(height: 5.h),
                            ElevatedButton(
                              onPressed: () {
                                Modular.to.pushNamed(
                                  '/home/detail/employee',
                                  arguments: state.employee![index],
                                );
                              },
                              child: Container(
                                width: double.infinity,
                                child: Center(
                                  child: Text("Detail"),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
                itemCount: state.employee?.length,
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
      // floatingActionButton: FloatingActionButton.small(
      //   onPressed: () {
      //     Modular.to.pushNamed('/home/create/employee');
      //   },
      //   child: Icon(
      //     Icons.add,
      //     color: Colors.white,
      //   ),
      //   backgroundColor: Colors.pink,
      // ),
    );
  }

  Widget appBarSearch() {
    if (_employeeBloc.isSearchEmployee) {
      return TextFormField(
        style: TextStyle(
          fontSize: 16.sp,
          color: Colors.white,
        ),
        decoration: InputDecoration(
          isDense: true,
          contentPadding: EdgeInsets.symmetric(
            vertical: 5.h,
          ),
          hintText: 'Search Employee',
          hintStyle: TextStyle(
            fontSize: 16.sp,
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
        onChanged: (value) {
          _employeeBloc.searchEmployee(value);
        },
      );
    }

    return Text("Employee");
  }
}
