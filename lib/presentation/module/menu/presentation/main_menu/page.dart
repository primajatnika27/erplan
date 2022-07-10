import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MainMenuPage extends StatefulWidget {
  const MainMenuPage({Key? key}) : super(key: key);

  @override
  State<MainMenuPage> createState() => _MainMenuPageState();
}

class _MainMenuPageState extends State<MainMenuPage> {
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
            onPressed: () {},
            icon: Icon(Icons.account_circle_rounded),
          ),
        ],
      ),
      body: CustomScrollView(
        slivers: [
          SliverPadding(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
            sliver: SliverGrid(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
                childAspectRatio: 0.9,
              ),
              delegate: SliverChildBuilderDelegate((context, index) {
                return Card(
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
                );
              }, childCount: 1),
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
    );
  }
}
