import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoaderStackWidget extends StatelessWidget {
  final String message;

  const LoaderStackWidget({
    Key? key,
    this.message = 'Tunggu Sebentar ...',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          margin: EdgeInsets.only(top: 12.w),
          alignment: Alignment.center,
          height: 32.w,
          width: 16.w,
          child: CircularProgressIndicator(
            strokeWidth: 3,
            color: Theme.of(context).canvasColor,
          ),
        ),
        SizedBox(height: 12.w),
        Center(
          child: Text(
            message,
            style: TextStyle(fontSize: 12.sp),
          ),
        ),
      ],
    );
  }
}
