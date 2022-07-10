import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../extension/context_extension.dart';
import '../../config/style_config.dart';

class ProBadgeWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 11),
      padding: EdgeInsets.only(
        left: 6.w,
        right: 6.w,
        top: 3.w,
        bottom: 2.w,
      ),
      decoration: BoxDecoration(
          color: AppColor.ERROR, borderRadius: BorderRadius.circular(3)),
      child: Text(
        'Pro',
        style: context.textTheme.bodyText1!.copyWith(
          fontSize: 10.sp,
          color: Colors.white,
        ),
      ),
    );
  }
}
