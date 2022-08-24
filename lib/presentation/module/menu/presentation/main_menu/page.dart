import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../data/repository_impl/employee_repository_impl.dart';
import '../../../../core/app.dart';
import '../../../../widget/block_loader.dart';
import '../employee/bloc.dart';

class MainMenuPage extends StatefulWidget {
  const MainMenuPage({Key? key}) : super(key: key);

  @override
  State<MainMenuPage> createState() => _MainMenuPageState();
}

class _MainMenuPageState extends State<MainMenuPage> {
  late EmployeeBloc _employeeBloc;

  @override
  void initState() {
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
        title: Text("erplan.id"),
        centerTitle: false,
        elevation: 1.0,
        actions: [
          IconButton(
            onPressed: () {
              Modular.to.pushNamed('/profile/');
            },
            icon: Icon(Icons.account_circle_rounded),
          ),
        ],
      ),
      body: BlocProvider(
        create: (context) => _employeeBloc,
        child: BlocListener<EmployeeBloc, EmployeeState>(
          listener: (context, state) {
            if (state is EmployeeLoadingState) {
              showDialog(
                context: context,
                builder: (_) => BlockLoader(),
              );
            }

            if (state is EmployeeSuccessState) {
              Navigator.of(context).pop();

              Modular.to.pushNamed('/home/leaves');
            }

            if (state is EmployeeRegisterGoState) {
              Navigator.of(context).pop();

              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: Text('Employee'),
                  content: Text(
                      'Your Account not Registered on Employee.\n\nPlease register now!'),
                  actions: [
                    ElevatedButton(
                      child: Text("Register"),
                      onPressed: () {
                        Modular.to.navigate('/home/create/employee');
                      },
                    ),
                  ],
                ),
              );
            }
          },
          child: CustomScrollView(
            slivers: [
              SliverPadding(
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
                sliver: SliverGrid.count(
                  crossAxisCount: 3,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                  childAspectRatio: 0.9,
                  children: [
                    Card(
                      child: InkWell(
                        onTap: () {
                          Modular.to.pushNamed('/home/employee');
                        },
                        child: Column(
                          children: [
                            Image.asset(
                              'assets/images/menu/ic_menu_employee.png',
                              height: 80.h,
                              width: 80.h,
                            ),
                            Expanded(
                              child: Padding(
                                padding: EdgeInsets.only(top: 10.h),
                                child: Text(
                                  "Employee",
                                  style: TextStyle(
                                    color: Colors.white54,
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    Card(
                      child: InkWell(
                        onTap: () {
                          _employeeBloc.getEmployeeByIdUser();
                        },
                        child: Column(
                          children: [
                            Image.asset(
                              'assets/images/menu/ic_menu_leaves.png',
                              height: 80.h,
                              width: 80.h,
                            ),
                            Expanded(
                              child: Padding(
                                padding: EdgeInsets.only(top: 10.h),
                                child: Text(
                                  "Leaves",
                                  style: TextStyle(
                                    color: Colors.white54,
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SliverFillRemaining(
                hasScrollBody: false,
                child: Container(
                  padding: EdgeInsets.only(bottom: 10.h),
                  alignment: Alignment.bottomCenter,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "Powered by",
                        style: TextStyle(
                          color: Colors.white54,
                          fontSize: 10.sp,
                        ),
                      ),
                      Text(
                        "erplan.id",
                        style: TextStyle(
                          color: Colors.white54,
                          fontSize: 13.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
