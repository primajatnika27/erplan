import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../../domain/entity/employee/employee_entity.dart';
import '../../../../../../widget/avatar_widget.dart';

class DetailEmployeePage extends StatefulWidget {
  final EmployeeEntity? entity;
  const DetailEmployeePage({
    Key? key,
    this.entity,
  }) : super(key: key);

  @override
  State<DetailEmployeePage> createState() => _DetailEmployeePageState();
}

class _DetailEmployeePageState extends State<DetailEmployeePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.favorite_border),
          ),
        ],
      ),
      body: CustomScrollView(
        slivers: [
          SliverList(
            delegate: SliverChildListDelegate(
              [
                Container(
                  color: Color.fromRGBO(43, 49, 56, 1),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 17.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: 40.h,
                          width: 40.h,
                          child: AvatarWidget(
                              imageUrl:
                                  'https://pbs.twimg.com/media/EigE7IkUMAEEiUR.jpg'),
                        ),
                        SizedBox(
                          height: 15.h,
                        ),
                        Text(
                          "${widget.entity!.fullName}",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14.sp,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        Text(
                          "${widget.entity!.salarySystem}",
                          style: TextStyle(
                            fontSize: 11.sp,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          "${widget.entity!.addressCity}, ${widget.entity!.addressFull}, ${widget.entity!.province}",
                          style: TextStyle(
                            fontSize: 11.sp,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(
                          height: 30.h,
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  color: Color.fromRGBO(43, 49, 56, 1),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 4.w),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        IconButton(
                          onPressed: () {},
                          iconSize: 17,
                          icon: Icon(Icons.call),
                        ),
                        IconButton(
                          onPressed: () {},
                          iconSize: 17,
                          icon: Icon(Icons.mail_outline_sharp),
                        ),
                        IconButton(
                          onPressed: () {},
                          iconSize: 17,
                          icon: Icon(Icons.chat),
                        ),
                        IconButton(
                          onPressed: () {},
                          iconSize: 17,
                          icon: Icon(Icons.link),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  color: Color.fromRGBO(30, 37, 43, 1),
                  height: 30.h,
                  child: Center(
                    child: Text(
                      'Profile Details',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ),
                ),

                /// ID EMPLOYEE
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 10.h,
                      ),
                      Text(
                        'Employee ID',
                        style: TextStyle(
                          color: Color.fromRGBO(120, 125, 131, 1),
                        ),
                      ),
                      SizedBox(
                        height: 5.h,
                      ),
                      Text(
                        '${widget.entity!.employeeId}',
                        style: TextStyle(
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                    ],
                  ),
                ),

                /// ID EMPLOYEE
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 10.h,
                      ),
                      Text(
                        'Education',
                        style: TextStyle(
                          color: Color.fromRGBO(120, 125, 131, 1),
                        ),
                      ),
                      SizedBox(
                        height: 5.h,
                      ),
                      Text(
                        '${widget.entity!.education}',
                        style: TextStyle(
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                    ],
                  ),
                ),

                /// Department
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 10.h,
                      ),
                      Text(
                        'Identity Number',
                        style: TextStyle(
                          color: Color.fromRGBO(120, 125, 131, 1),
                        ),
                      ),
                      SizedBox(
                        height: 5.h,
                      ),
                      Text(
                        '${widget.entity!.identityNo}',
                        style: TextStyle(
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                    ],
                  ),
                ),

                /// Phone Number
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 10.h,
                      ),
                      Text(
                        'Phone Number',
                        style: TextStyle(
                          color: Color.fromRGBO(120, 125, 131, 1),
                        ),
                      ),
                      SizedBox(
                        height: 5.h,
                      ),
                      Text(
                        '${widget.entity!.phoneNo}',
                        style: TextStyle(
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
