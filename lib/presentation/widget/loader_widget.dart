import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoaderWidget extends StatelessWidget {
  final String message;

  const LoaderWidget({
    Key? key,
    this.message = 'Tunggu Sebentar ...',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12.w),
      color: Theme.of(context).backgroundColor,
      child: Column(
        children: [
          SizedBox(
            height: 16.w,
            width: 16.w,
            child: CircularProgressIndicator(
              strokeWidth: 3,
              color: Theme.of(context).canvasColor,
            ),
          ),
          SizedBox(height: 12.w),
          Text(
            message,
            style: TextStyle(fontSize: 12.sp),
          ),
        ],
      ),
    );
  }
}
